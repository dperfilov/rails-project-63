# frozen_string_literal: true

module HexletCode
  class FormGenerator
    attr_accessor :entity, :form_body

    def initialize(entity, **options)
      @entity = entity
      @action = options.fetch(:url, '#')
      @method = options.fetch(:method, 'post')

      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: { action: @action, method: @method }.merge(options.except(:url, :method))
      }
    end

    def input(value_key, options = {})
      field_type = get_field_type(options)
      options_modified = options.except(:as)

      value = @entity.public_send(value_key)

      options_modified[:name] = value_key

      @form_body[:inputs] << HexletCode::Tag.build('label', { for: value_key }) { value_key.capitalize }

      @form_body[:inputs] << generate_input(options_modified, field_type, value)
    end

    def submit(btn_name = 'Save', options = {})
      options[:type] = 'submit'
      options[:value] = btn_name

      @form_body[:inputs] << HexletCode::Tag.build('input', options)
    end

    private

    def get_field_type(options)
      options.key?(:as) ? options[:as].to_s : 'string'
    end

    def generate_input(options, field_type, value)
      "HexletCode::Inputs::#{field_type.capitalize}Input".constantize.build(options, value)
    end
  end
end
