# frozen_string_literal: true

module Packager
  class Group
    attr_reader :title
    attr_reader :packages

    def initialize(title, &block)
      @title = title
      @packages = []

      instance_eval &block
    end

    private

    def package(package)
      packages << package
    end
  end
end
