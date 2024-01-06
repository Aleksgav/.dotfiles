# frozen_string_literal: true

class Executor
  attr_accessor :success_mark,
                :error_mark,
                :err_suffix,
                :ok_suffix,
                :spinner_title,
                :spinner_format,
                :spinner_group_style,
                :err_printer

  def initialize(err_printer)
    @err_printer = err_printer

    init_styles
  end

  def run(installation, context, **options)
    @context = context

    installation.installation.each do |value|
      case value
      in Packager::Package then exec(value, **options)
      in Packager::Group then exec_group(value, **options)
      end
    end
  end

  private

  attr_reader :context

  def exec(package, **options)
    spinner = TTY::Spinner.new(spinner_title, **spinner_format)
    spinner.update(title: package.title)

    exec_with_spinner(spinner, package, **options)
  end

  def exec_group(group, **options)
    sp_group = TTY::Spinner::Multi.new(make_group_title(group.title), style: spinner_group_style, **spinner_format)

    group.packages.each do |package|
      spinner = sp_group.register(spinner_title, **spinner_format)
      spinner.update(title: package.title)

      exec_with_spinner(spinner, package, **options)
    end
  end

  def exec_with_spinner(spinner, package, dry_run: false)
    spinner.run do |spnr|
      spnr.success(ok_suffix) and next([0, 'success']) if dry_run

      *, stderr, wait_thr = package.install(context)

      wait_thr.value.exitstatus.zero? ? spnr.success(ok_suffix) : spnr.error(err_suffix)

      [wait_thr.value.exitstatus, stderr.read]
    rescue Errno::ENOENT => e
      [1, e.message]
    end.join
  end

  def init_styles
    @success_mark = Styles::SUCCESS_MARK["#{TTY::Spinner::TICK}"]
    @error_mark = Styles::ERROR_MARK["#{TTY::Spinner::CROSS}"]

    @err_suffix = Styles::ERROR['[err]']
    @ok_suffix = Styles::SUCCESS['[ok]']

    @spinner_title = Styles::WHITE['['] +
                     Styles::SPINNER[':spinner'] +
                     Styles::WHITE['] '] +
                     Styles::WHITE['Installation: '] +
                     Styles::PACKAGE[':title']

    @spinner_format = { format: :dots, success_mark: success_mark, error_mark: error_mark }
    @spinner_group_style = { top: '', middle: ' ├──', bottom: ' └── ' }
  end

  def make_group_title(title)
    Styles::WHITE['['] + Styles::SPINNER[':spinner'] + Styles::WHITE['] '] + Styles::WHITE[title]
  end
end
