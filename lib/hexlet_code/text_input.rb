require_relative 'base_input'

module HexletCode
  module Inputs
    class TextInput < BaseInput
      def self.build(params, value)
        params[:cols] = 20 unless params.key?(:cols)
        params[:rows] = 40 unless params.key?(:rows)

        HexletCode::Tag.build('textarea', params) { value }
      end
    end
  end
end
