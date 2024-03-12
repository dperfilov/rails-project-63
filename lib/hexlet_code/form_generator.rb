# frozen_string_literal: true

require 'active_support/inflector'

module HexletCode
  class FormGenerator
    attr_accessor :entity, :form_body

    def initialize(entity, **params)
      @entity = entity
      @params = params

      @action = params.fetch(:url, '#')
      @method = params.fetch(:method, 'post')

      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: { action: @action, method: @method }.merge(params.except(:url, :method))
      }
    end

    def input(value_key, params = {})
      field_type = get_field_type(params)
      params.delete(:as)

      value = @entity.public_send(value_key)

      params[:name] = value_key

      @form_body[:inputs] << HexletCode::Tag.build('label', { for: value_key }) { value_key.capitalize }

      @form_body[:inputs] << generate_input(params, field_type, value)
    end

    def submit(btn_name = 'Save', params = {})
      params[:type] = 'submit'
      params[:value] = btn_name

      @form_body[:inputs] << HexletCode::Tag.build('input', params)
    end

    private

    def get_field_type(params)
      params.key?(:as) ? params[:as].to_s : 'string'
    end

    def generate_input(params, field_type, value)
      "HexletCode::Inputs::#{field_type.capitalize}Input".constantize.build(params, value)
    end
  end
end
