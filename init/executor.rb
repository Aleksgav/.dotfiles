# frozen_string_literal: true

require 'open3'
require 'tty-box'
require 'tty-screen'
require 'tty-spinner'

class Executor
  attr_accessor :commands,
                :success_mark,
                :error_mark,
                :err_suffix,
                :ok_suffix,
                :spinner_title,
                :spinner,
                :err_printer

  def initialize(err_printer)
    @err_printer = err_printer

    init_styles
    init_spinner
    init_state
  end

  def register(description, command)
    commands.push([description, command])
  end

  def run(**options)
    commands.each do |command|
      exit_status, err_message = exec(*command, **options).value

      err_printer.print(err_message) unless exit_status.zero?
    end
  end

  private

  def init_state
    @commands = []
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
  end

  def init_spinner
    @spinner = TTY::Spinner.new(spinner_title, format: :dots, success_mark: success_mark, error_mark: error_mark)
  end

  def exec(title, command, dry_run: false)
    spinner.update(title: title)

    spinner.run do |spnr|
      spnr.success(ok_suffix) and next([0, 'success']) if dry_run

      *, stderr, wait_thr = Open3.popen3(command)

      wait_thr.value.exitstatus.zero? ? spnr.success(ok_suffix) : spnr.error(err_suffix)

      [wait_thr.value.exitstatus, stderr.read]
    rescue Errno::ENOENT => e
      [1, e.message]
    end.join
  end
end
