# frozen_string_literal: true

module HexletCode
  module Inputs
    class SubmitInput < BaseInput
      def self.build(options, value)
        options[:type] = 'submit'
        options[:value] = value

        HexletCode::Tag.build('input', options)
      end
    end
  end
end
