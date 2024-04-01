# frozen_string_literal: true

module HexletCode
  module Inputs
    autoload :BaseInput, "#{__dir__}/inputs/base_input"
    autoload :StringInput, "#{__dir__}/inputs/string_input"
    autoload :TextInput, "#{__dir__}/inputs/text_input"
  end
end
