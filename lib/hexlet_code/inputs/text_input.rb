module HexletCode
  module Inputs
    class TextInput < BaseInput
      COLS = 20
      ROWS = 40

      def self.build(options, value)
        options[:cols] = COLS unless options.key?(:cols)
        options[:rows] = ROWS unless options.key?(:rows)

        HexletCode::Tag.build('textarea', options) { value }
      end
    end
  end
end
