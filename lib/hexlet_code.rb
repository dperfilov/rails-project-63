# frozen_string_literal: true

require 'active_support/inflector'

module HexletCode
  autoload :HexletCode, "#{__dir__}/hexlet_code/version"
  autoload :Tag, "#{__dir__}/hexlet_code/tag"
  autoload :FormGenerator, "#{__dir__}/hexlet_code/form_generator"
  autoload :FormRender, "#{__dir__}/hexlet_code/form_render"

  autoload :Inputs, "#{__dir__}/hexlet_code/inputs"

  class Error < StandardError; end

  def self.form_for(entity, options = {})
    form_template = FormGenerator.new(entity, **options)

    yield(form_template) if block_given?

    FormRender.render_form(form_template)
  end
end

User = Struct.new(:name, :job, keyword_init: true)
user = User.new job: 'hexlet'

    @user_with_gender = Struct.new(:name, :job, :gender, keyword_init: true)
    @user_rob_with_gender = @user_with_gender.new name: 'rob', job: 'hexlet', gender: 'm'

form =   HexletCode.form_for @user_rob_with_gender, url: '#' do |f|
      f.input :job, as: :text, cols: 50, rows: 50
    end
