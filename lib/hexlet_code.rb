# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative 'tag_module'

module HexletCode
  class Error < StandardError; end

  class Tag
    extend TagModule
  end


  def self.form_for(user, params={})
    build_params = {}

    # 'action' attribute for form based on 'url' param
    params.key?(:url) ? build_params[:action] = params[:url] : build_params[:action] = '#'
    build_params[:method] = 'post'

    HexletCode::Tag.build('form', build_params)
  end
end

# puts HexletCode::Tag.build('br')
# puts HexletCode::Tag.build('input', type: 'submit', value: 'Save')

# Создаем класс User с полями name и job
# User = Struct.new(:name, :job, keyword_init: true)
# # Создаем конкретно пользователя и заполняем имя
# user = User.new name: 'rob'


# puts HexletCode.form_for(user)
# puts HexletCode.form_for(user, url: '/users')
