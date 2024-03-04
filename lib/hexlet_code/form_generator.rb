# frozen_string_literal: true

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

      @form_body[:inputs] << generate_field(params, field_type, value)
    end

    def submit(btn_name = 'Save', params = {})
      params[:type] = 'submit'
      params[:value] = btn_name

      @form_body[:inputs] << HexletCode::Tag.build('input', params)
    end

    def get_field_type(params)
      field_type = params.key?(:as) ? params[:as].to_s : 'input'
      field_type = 'textarea' if field_type == 'text'

      field_type
    end

    def generate_field(params, field_type, value)
      result = ''

      if field_type == 'input'
        params[:type] = 'text'
        params[:value] = value

        result = HexletCode::Tag.build(field_type, params)
      else
        params[:cols] = 20 unless params.key?(:cols)
        params[:rows] = 40 unless params.key?(:rows)

        result = HexletCode::Tag.build(field_type, params) { value }
      end

      result
    end
  end
end
