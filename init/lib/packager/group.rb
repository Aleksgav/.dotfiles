# frozen_string_literal: true

module Packager
  class Group
    include Packager::Conditional

    attr_reader :title, :packages

    def initialize(title, chassis: nil, condition: nil, &block)
      @title = title
      @packages = []
      @conditions = []

      add_chassis(chassis) unless chassis.nil?
      add_condition(condition) unless condition.nil?

      instance_eval(&block)
    end

    private

    def add_chassis(values)
      values = Array(values)
      conditions << Condition.new(
        "chassis: #{values.join('/')}",
        ->(host) { values.include?(host.chassis) }
      )
    end

    def add_condition(predicate)
      conditions << Condition.new('custom', predicate)
    end

    def package(package)
      packages << package
    end
  end
end
