# frozen_string_literal: true

module Packager
  class Installation
    attr_reader :installation

    def initialize(&block)
      @installation = []

      instance_eval &block
    end

    def call(**options)
      executor.run(**options.slice(:dry_run))
    end

    private

    def group(title, &block)
      group = Group.new(title, &block)

      installation << group
    end

    def package(package)
      installation << package
    end
  end
end
