# frozen_string_literal: true

class Executor
  Styles = Packager::Styles

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
    exec_command(package, **options)
  end

  def exec_group(group, **options)
    group.packages.each do |package|
      exec_command(package, **options)
    end
  end

  def exec_command(package, dry_run: false)
    puts Styles::PKG_TITLE_PREFIX["[ "] + Styles::PKG_TITLE[package.title] + Styles::PKG_TITLE_PREFIX[" ]"]

    return if dry_run

    stdin, stdout, stderr, wait_thr = package.install(context)

    wait_thr.run

    print_out(stdout) unless stdout.eof?

    wait_thr.value

    print_err(stderr) unless wait_thr.value.exitstatus.zero?
  end

  def print_out(stdout)
    print_header("STDOUT")

    until stdout.eof?
       puts Styles::OUT_PREFIX["-> "] << stdout.gets.chomp
    end
  end

  def print_err(stderr)
    print_header("STDERR", err: true)

    until stderr.eof?
      puts Styles::ERR_PREFIX["-> "] << stderr.gets
    end
  end

  def print_header(message, err: false)
    screen_width = TTY::Screen.width
    left_pad = (screen_width - message.length) / 2

    output = " " + message + " " + "/" * (screen_width - message.length - 3) + " "

    puts err ? Styles::HEADER_ERR[output] : Styles::HEADER_OUT[output]
  end

    Packager::Styles

  # def pastel
  #   @pastel ||= Pastel.new
  # end
end
