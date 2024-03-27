# frozen_string_literal: true

module HexletCode
  module Inputs
    class TextInput < BaseInput
      COLS = 20
      ROWS = 40

      def self.build(options, value)
        options[:cols] = COLS unless options.key?(:cols)
        options[:rows] = ROWS unless options.key?(:rows)

        input = HexletCode::Tag.build('textarea', options) { value }

        self.label(options[:name]) + input
      end
    end
  end
end
