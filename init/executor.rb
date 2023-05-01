# frozen_string_literal: true

require 'open3'
require 'tty-box'
require 'tty-screen'
require 'tty-spinner'

require_relative 'command_register'

class Executor
  attr_accessor :commands,
                :success_mark,
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
    init_state
  end

  def register(&block)
    return unless block_given?

    commands_register = CommandRegister.new
    block[commands_register]

    @commands = commands_register.commands
  end

  def run(**options)
    commands.each do |command|
      case command
          in { description:, command: } then exec(description, command, **options)
          in { description:, group: } then exec_group(description, group, **options)
      end
    end
  end

  private

  def exec(title, command, **options)
    spinner = TTY::Spinner.new(spinner_title, **spinner_format)
    spinner.update(title: title)

    exec_with_spinner(spinner, command, **options)
  end

  def exec_group(description, group, **options)
    sp_group = TTY::Spinner::Multi.new(make_group_title(description), style: spinner_group_style, **spinner_format)

    group.each do |row|
      row => { description:, command: }

      spinner = sp_group.register(spinner_title, **spinner_format)
      spinner.update(title: description)

      exec_with_spinner(spinner, command, **options)
    end
  end

  def exec_with_spinner(spinner, command, dry_run: false)
    spinner.run do |spnr|
      spnr.success(ok_suffix) and next([0, 'success']) if dry_run

      *, stderr, wait_thr = Open3.popen3(command)

      wait_thr.value.exitstatus.zero? ? spnr.success(ok_suffix) : spnr.error(err_suffix)

      [wait_thr.value.exitstatus, stderr.read]
    rescue Errno::ENOENT => e
      [1, e.message]
    end.join
  end

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

    @spinner_format = { format: :dots, success_mark: success_mark, error_mark: error_mark }
    @spinner_group_style = { top: '', middle: ' ├──', bottom: ' └── ' }
  end

  def make_group_title(title)
    Styles::WHITE['['] + Styles::SPINNER[':spinner'] + Styles::WHITE['] '] + Styles::WHITE[title]
  end
end
