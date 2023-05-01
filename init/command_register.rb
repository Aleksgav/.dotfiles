# frozen_string_literal: true

class CommandRegister
  attr_reader :commands

  def initialize
    @commands = []
  end

  def command(description, command)
    commands.push({ description: description, command: command })
  end

  def command_group(description, &block)
    return unless block_given?

    group = self.class.new

    block[group]

    commands.push({ description: description, group: group.commands })
  end
end
