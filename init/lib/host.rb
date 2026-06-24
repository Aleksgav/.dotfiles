# frozen_string_literal: true

require 'open3'

# Host facts detected on the target machine at install time. Used by Packager
# conditions to gate packages/groups (e.g. `chassis :laptop`).
#
# Detection is memoized and resolves in this order:
#   1. ENV['CHASSIS']                     — explicit override / testing escape hatch
#   2. `hostnamectl chassis`              — systemd, authoritative on Arch
#   3. /sys/class/dmi/id/chassis_type     — DMI numeric fallback
#   4. /sys/class/power_supply/BAT*       — battery presence ⇒ laptop
#   5. :unknown                           — undetectable (laptop-only items are skipped)
module Host
  module_function

  # DMI chassis_type codes that denote a portable/laptop-class machine.
  # 8 portable, 9 laptop, 10 notebook, 11 hand held, 14 sub notebook,
  # 30 tablet, 31 convertible, 32 detachable.
  LAPTOP_DMI_CODES = [8, 9, 10, 11, 14, 30, 31, 32].freeze

  def chassis
    @chassis ||= detect_chassis
  end

  def laptop?
    chassis == :laptop
  end

  def desktop?
    chassis == :desktop
  end

  def vm?
    chassis == :vm
  end

  def detect_chassis
    from_env || from_hostnamectl || from_dmi || from_battery || :unknown
  end

  def from_env
    value = ENV['CHASSIS']
    return nil if value.nil? || value.strip.empty?

    value.strip.downcase.to_sym
  end

  def from_hostnamectl
    out, status = Open3.capture2('hostnamectl', 'chassis')
    return nil unless status.success?

    value = out.strip
    value.empty? ? nil : value.downcase.to_sym
  rescue SystemCallError
    nil
  end

  def from_dmi
    path = '/sys/class/dmi/id/chassis_type'
    return nil unless File.readable?(path)

    code = File.read(path).strip.to_i
    LAPTOP_DMI_CODES.include?(code) ? :laptop : :desktop
  rescue SystemCallError
    nil
  end

  def from_battery
    Dir.glob('/sys/class/power_supply/BAT*').empty? ? nil : :laptop
  end
end
