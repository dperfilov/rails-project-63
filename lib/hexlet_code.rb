# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative 'tag_module'

module HexletCode
  class Error < StandardError; end

  class Tag
    extend TagModule
  end

  class FormGenerator
    attr_accessor :user, :params, :fields

    def initialize(user, **params)
      @user = user
      @params = params
      @fields = []
    end

    def input value_key, params={}
      # get field type from params ('as' parameter)
      params.key?(:as) ? field_type = params[:as].to_s : field_type = 'input'
      params.delete(:as)
      field_type = 'textarea' if field_type=='text'

      # get value from User object
      value = @user.public_send(value_key)

      # add 'name' attribute
      params[:name] = value_key
      

      # add label before each field
      @fields << HexletCode::Tag.build('label', {for: value_key}) { value_key.capitalize }

      if field_type == 'input'
        # for imnput field
        params[:type] = 'text'
        params[:value] = value

        @fields << HexletCode::Tag.build(field_type, params)
      else
        # for textarea field
        params[:cols] = 20 unless params.key?(:cols)
        params[:rows] = 40 unless params.key?(:rows)

        @fields << HexletCode::Tag.build(field_type, params) { value }
      end
    end

    def submit btnName='Save', params={}
      # input type
      params[:type] = 'submit'
      # button name
      params[:value] = btnName
      
      @fields << HexletCode::Tag.build('input', params)
    end

    def self.render_form form_template
      HexletCode::Tag.build('form', convert_params(form_template.params), form_template.fields)
    end


    private
    def self.convert_params params
      # build_params = {}

      # 'action' attribute for form based on 'url' param
      if !params.key?(:action)
        if params.key?(:url)
          params[:action] = params.delete(:url) # replace 'url' key to 'action' key
        else 
          params[:action] = '#'
        end
      end

      # add default method
      if !params.key?(:method)
        params[:method] = 'post'
      end

      params
    end
  end


  def self.form_for(user, params={})
    form_template = FormGenerator.new(user, **params)

    yield(form_template) if block_given?

    FormGenerator.render_form(form_template)
  end

  # # sample from Vladimir
  # def self.form_for(user, attributes = {})
  #   builded_form = FormBuilder.new(user, **attributes)
  #   yield(builded_form) if block_given?
  #   FormRender.render_html(builded_form.form_body)
  # end
end