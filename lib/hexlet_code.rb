# frozen_string_literal: true

module HexletCode
  autoload :HexletCode, "#{__dir__}/hexlet_code/version"
  autoload :Tag, "#{__dir__}/hexlet_code/tag"
  autoload :FormGenerator, "#{__dir__}/hexlet_code/form_generator"
  autoload :FormRender, "#{__dir__}/hexlet_code/form_render"

  class Error < StandardError; end

  def self.form_for(entity, params = {})
    form_template = FormGenerator.new(entity, **params)

    yield(form_template) if block_given?

    FormRender.render_form(form_template)
  end
end
