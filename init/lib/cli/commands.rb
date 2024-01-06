# frozen_string_literal: true

module CLI
  module Commands
    extend ::Dry::CLI::Registry

    CONTEXT = Context.new
  end
end
