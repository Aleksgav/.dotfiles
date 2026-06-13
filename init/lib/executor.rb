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
    package.steps.each do |step|
      run_step(package, step, dry_run: dry_run)
    end
  end

  def run_step(package, step, dry_run: false)
    puts step_title(package, step)

    return if dry_run

    _stdin, stdout, stderr, wait_thr = step.run(context)

    out_reader = Thread.new { stdout.read }
    err_reader = Thread.new { stderr.read }
    out = out_reader.value
    err = err_reader.value

    status = wait_thr.value

    # Success: stay quiet
    return if status.exitstatus&.zero?

    # Failure: output all
    print_out(out) unless out.empty?
    print_err(err) unless err.empty?
  rescue SystemCallError => e
    # Prevent abort execution on error
    print_err(e.message)
  end

  def step_title(package, step)
    label = package.title
    label += " (#{step.label_suffix})" if step.label_suffix

    Styles::PKG_TITLE_PREFIX['[ '] + Styles::PKG_TITLE[label] + Styles::PKG_TITLE_PREFIX[' ]']
  end

  def print_out(output)
    print_header('STDOUT')

    output.each_line do |line|
      puts Styles::OUT_PREFIX['-> '] << line.chomp
    end
  end

  def print_err(output)
    print_header('STDERR', err: true)

    output.each_line do |line|
      puts Styles::ERR_PREFIX['-> '] << line.chomp
    end
  end

  def print_header(message, err: false)
    screen_width = TTY::Screen.width
    left_pad = (screen_width - message.length) / 2

    output = ' ' + message + ' ' + '/' * (screen_width - message.length - 3) + ' '

    puts err ? Styles::HEADER_ERR[output] : Styles::HEADER_OUT[output]
  end
end
