# frozen_string_literal: true

module HexletCode
  SINGLE_TAGS = %w[input img br].freeze

  class Tag
    def self.build(tag_name, options = {}, fields = [])
      if SINGLE_TAGS.include?(tag_name)
        return "<#{tag_name}#{tag_options(options)}>#{yield if block_given?}"
      else
        return "<#{tag_name}#{tag_options(options)}>#{fields.join}#{yield if block_given?}</#{tag_name}>"
      end
    end

    private
    def self.tag_options(options)
      result = ""
      unless options.empty?
        options.each do |key, value|
          result += " #{key}=\"#{value}\""
        end
      end

      result
    end
  end
end
