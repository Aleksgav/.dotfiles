# frozen_string_literal: true

module Packager
  # Uniform outcome of a Step
  Result = Struct.new(:out, :err, :ok, keyword_init: true) do
    def ok? = ok
  end
end
