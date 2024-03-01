# frozen_string_literal: true

module HexletCode
  class FormGenerator
    attr_accessor :entity, :form_body

    def initialize(entity, **params)
      @entity = entity
      @params = params
      # @fields = []

      @action = params.fetch(:url, '#')
      @method = params.fetch(:method, 'post')

      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: { action: @action, method: @method }.merge(params.except(:url, :method))
      }
    end

    def input(value_key, params = {})
      # get field type from params ('as' parameter)
      field_type = get_field_type(params)
      params.delete(:as)

      # get value from entity object
      value = @entity.public_send(value_key)

      # add 'name' attribute
      params[:name] = value_key

      # add label before each field
      @form_body[:inputs] << HexletCode::Tag.build('label', { for: value_key }) { value_key.capitalize }

      @form_body[:inputs] << generate_field(params, field_type, value)
    end

    def submit(btn_name = 'Save', params = {})
      # input type
      params[:type] = 'submit'
      # button name
      params[:value] = btn_name

      @form_body[:inputs] << HexletCode::Tag.build('input', params)
    end

    def self.render_form(form_template)
      HexletCode::Tag.build('form', form_template.form_body[:form_options], form_template.form_body[:inputs])
    end

    # def self.convert_params(params)
    #   # 'action' attribute for form based on 'url' param
    #   unless params.key?(:action)
    #     params[:action] = if params.key?(:url)
    #                         params.delete(:url) # replace 'url' key to 'action' key
    #                       else
    #                         '#'
    #                       end
    #   end

    #   # add default method
    #   params[:method] = 'post' unless params.key?(:method)

    #   params
    # end

    def get_field_type(params)
      field_type = params.key?(:as) ? params[:as].to_s : 'input'
      field_type = 'textarea' if field_type == 'text'

      field_type
    end

    def generate_field(params, field_type, value)
      result = ''

      if field_type == 'input'
        # for input field
        params[:type] = 'text'
        params[:value] = value

        result = HexletCode::Tag.build(field_type, params)
      else
        # for textarea field
        params[:cols] = 20 unless params.key?(:cols)
        params[:rows] = 40 unless params.key?(:rows)

        result = HexletCode::Tag.build(field_type, params) { value }
      end

      result
    end
  end
end
