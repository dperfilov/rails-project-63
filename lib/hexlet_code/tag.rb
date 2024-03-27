# frozen_string_literal: true

module HexletCode
  SINGLE_TAGS = %w[input img br].freeze

  class Tag
    def self.build(tag_name, options = {}, inputs = [], submit = {})
      return "<#{tag_name}#{tag_options(options)}>" if SINGLE_TAGS.include?(tag_name)

      inputs = generate_inputs(inputs)
      submit = generate_submit(submit)
      "<#{tag_name}#{tag_options(options)}>#{inputs}#{yield if block_given?}#{submit}</#{tag_name}>"
    end

    def self.generate_submit(submit)
      HexletCode::Tag.build('input', submit[:options]) { submit[:value] } if submit[:options]
    end

    def self.generate_inputs(inputs)
      result = ''
      inputs.each do |input|
        result += HexletCode::Tag.build('label', input[:label][:options]) { input[:label][:body] } if input[:label]
        result += "HexletCode::Inputs::#{input[:field_type].capitalize}Input".constantize.build(input[:options], input[:value])
      end

      result
    end

    def self.tag_options(options)
      result = ''
      unless options.empty?
        options.each do |key, value|
          result += " #{key}=\"#{value}\""
        end
      end

      result
    end
  end
end
