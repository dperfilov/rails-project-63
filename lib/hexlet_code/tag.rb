# frozen_string_literal: true

module HexletCode
  SINGLE_TAGS = %w[input img br].freeze

  class Tag
    def self.build(tag_name, options = {}, fields = [])
      result = []
      result << '<'
      result << tag_name

      unless options.empty?
        options.each do |key, value|
          result << " #{key}=\"#{value}\""
        end
      end

      result << '>'
      result << yield if block_given?
      result << fields unless fields.empty?
      result << "</#{tag_name}>" unless SINGLE_TAGS.include? tag_name

      result.join
    end
  end
end
