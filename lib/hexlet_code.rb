# frozen_string_literal: true

module HexletCode
  autoload :HexletCode, "#{__dir__}/hexlet_code/version"
  autoload :Tag, "#{__dir__}/hexlet_code/tag"
  autoload :FormGenerator, "#{__dir__}/hexlet_code/form_generator"

  class Error < StandardError; end

  def self.form_for(entity, params = {})
    form_template = FormGenerator.new(entity, **params)

    yield(form_template) if block_given?

    FormGenerator.render_form(form_template)
  end
end


User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

HexletCode.form_for user do |f|
  # Проверяет есть ли значение внутри name
  f.input :name
  # Проверяет есть ли значение внутри job
  f.input :job, as: :text
end