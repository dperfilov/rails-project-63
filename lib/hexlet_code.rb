# frozen_string_literal: true

require 'active_support/inflector'

module HexletCode
  autoload :HexletCode, "#{__dir__}/hexlet_code/version"
  autoload :Tag, "#{__dir__}/hexlet_code/tag"
  autoload :FormGenerator, "#{__dir__}/hexlet_code/form_generator"
  autoload :FormRender, "#{__dir__}/hexlet_code/form_render"

  autoload :Inputs, "#{__dir__}/hexlet_code/inputs"
  # autoload :BaseInput, "#{__dir__}/hexlet_code/base_input"

  # autoload :Inputs, "#{__dir__}/hexlet_code/string_input"
  # autoload :StringInput, "#{__dir__}/hexlet_code/string_input"

  # autoload :Inputs, "#{__dir__}/hexlet_code/text_input"
  # #autoload :TextInput, "#{__dir__}/hexlet_code/text_input"

  class Error < StandardError; end

  def self.form_for(entity, params = {})
    form_template = FormGenerator.new(entity, **params)

    yield(form_template) if block_given?

    FormRender.render_form(form_template)
  end
end
