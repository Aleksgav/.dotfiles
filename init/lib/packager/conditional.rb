# frozen_string_literal: true

module Packager
  module Conditional
    def conditions
      @conditions ||= []
    end

    def runs_on?(host)
      conditions.all? { |condition| condition.met?(host) }
    end

    def skip_reasons(host)
      conditions.reject { |condition| condition.met?(host) }.map(&:label)
    end
  end
end
