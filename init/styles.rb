require 'pastel'

module Styles
  pastel = Pastel.new

  SPINNER = pastel.blue.bold.detach

  WHITE = pastel.white.detach
  PACKAGE = pastel.green.underline.detach
  SUCCESS_MARK = pastel.green.bold.detach
  ERROR_MARK = pastel.red.bold.detach

  ERROR = pastel.red.bold.detach
  SUCCESS = pastel.white.bold.detach
end
