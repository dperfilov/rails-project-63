# frozen_string_literal: true

module HexletCode
  module Inputs
    class StringInput < BaseInput
      def self.build(options, value)
        options[:type] = 'text'
        options[:value] = value

        input = HexletCode::Tag.build('input', options)

        self.label(options[:name]) + input
      end
    end
  end
end
