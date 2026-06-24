# frozen_string_literal: true

module Packager
  Condition = Struct.new(:label, :predicate) do
    def met?(host)
      predicate.call(host)
    end
  end
end
