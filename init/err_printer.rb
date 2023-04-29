# frozen_string_literal: true

require_relative 'styles'

class ErrPrinter
  attr_reader :border_h, :border_h_symbol

  DEFAULT_BORDER_H_SYMBOL = '-'.freeze

  def initialize(**params)
    symbol_h = params[:symbol_h]

    @border_h_symbol = symbol_h.nil? ? DEFAULT_BORDER_H_SYMBOL : symbol_h

    @border_h = Styles::ERROR[border_h_symbol * TTY::Screen.width]
  end

  def print(err)
    puts border_h
    puts err
    puts border_h
  end
end
