# frozen_string_literal: true

module HexletCode
  module Inputs
    class BaseInput
      def self.label(name)
        HexletCode::Tag.build('label', { for: name }) { name.capitalize }
      end
    end
  end
end
