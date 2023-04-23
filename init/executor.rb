require 'open3'
require 'tty-box'
require 'tty-screen'
require 'tty-spinner'

class Executor
  attr_accessor :success_mark, :error_mark, :err_suffix, :ok_suffix, :spinner_title, :spinner, :err_output, :exit_status

  def initialize
    @success_mark = Styles::SUCCESS_MARK["#{TTY::Spinner::TICK}"]
    @error_mark = Styles::ERROR_MARK["#{TTY::Spinner::CROSS}"]

    @err_suffix = Styles::ERROR['[err]']
    @ok_suffix = Styles::SUCCESS['[ok]']

    @spinner_title = Styles::WHITE['['] +
                     Styles::SPINNER[':spinner'] +
                     Styles::WHITE['] '] +
                     Styles::WHITE['Installation: '] +
                     Styles::PACKAGE[':title']

    @spinner = TTY::Spinner.new(spinner_title, format: :dots, success_mark: success_mark, error_mark: error_mark)
    @err_output = ''
  end

  def exec(package, command)
    err_output.clear
    @exit_status = 0
    spinner.update(title: package)

    spinner.run do |spnr|
      *, stderr, wait_thr = Open3.popen3(command)

      wait_thr.value.exitstatus.zero? ? spnr.success(ok_suffix) : spnr.error(err_suffix)

      @exit_status = wait_thr.value.exitstatus
      @err_output = stderr.read unless wait_thr.value.exitstatus.zero?
    rescue Errno::ENOENT => e
      @exit_status = 1
      @err_output = e.message
    end
  end
end
