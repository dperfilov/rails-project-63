module HexletCode
  module Inputs
    class StringInput < BaseInput
      def self.build(options, value)
        options[:type] = 'text'
        options[:value] = value

        HexletCode::Tag.build('input', options)
      end
    end
  end
end
