# frozen_string_literal: true

module HexletCode
  autoload :HexletCode, "#{__dir__}/hexlet_code/version"
  autoload :Tag, "#{__dir__}/hexlet_code/tag"
  autoload :FormGenerator, "#{__dir__}/hexlet_code/form_generator"

  class Error < StandardError; end

  def self.form_for(user, params = {})
    form_template = FormGenerator.new(user, **params)

    yield(form_template) if block_given?

    FormGenerator.render_form(form_template)
  end
end
