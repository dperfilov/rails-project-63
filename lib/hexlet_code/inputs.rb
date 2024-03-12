module HexletCode
  module Inputs
    class BaseInput
    end

    class StringInput < BaseInput
      def self.build(params, value)
        params[:type] = 'text'
        params[:value] = value

        HexletCode::Tag.build('input', params)
      end
    end

    class TextInput < BaseInput
      def self.build(params, value)
        params[:cols] = 20 unless params.key?(:cols)
        params[:rows] = 40 unless params.key?(:rows)

        HexletCode::Tag.build('textarea', params) { value }
      end
    end
  end
end
