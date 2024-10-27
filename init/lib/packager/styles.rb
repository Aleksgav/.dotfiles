# frozen_string_literal: true

require 'pastel'

module Packager
  module Styles
    pastel = Pastel.new

    HEADER_ERR = pastel.white.on_red.bold.detach
    HEADER_OUT = pastel.white.bold.detach

    ERR_PREFIX = pastel.red.bold.detach
    OUT_PREFIX = pastel.green.bold.detach

    PKG_TITLE_PREFIX = pastel.bold.green.detach
    PKG_TITLE = pastel.white.detach
  end
end
