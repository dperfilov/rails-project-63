module HexletCode
  module Inputs
    autoload :BaseInput, "#{__dir__}/inputs/base_input"
    autoload :StringInput, "#{__dir__}/inputs/string_input"
    autoload :TextInput, "#{__dir__}/inputs/text_input"
    autoload :SubmitInput, "#{__dir__}/inputs/submit_input"
  end
end
