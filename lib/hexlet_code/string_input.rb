require_relative 'base_input'

module HexletCode
  module Inputs
    class StringInput < BaseInput
      def self.build(params, value)
        params[:type] = 'text'
        params[:value] = value

        HexletCode::Tag.build('input', params)
      end
    end
  end
end
