# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative 'tag_module'

module HexletCode
  class Error < StandardError; end

  class Tag
    extend TagModule
  end


  def self.form_for
  end
end

puts HexletCode::Tag.build('br')

# Создаем класс User с полями name и job
User = Struct.new(:name, :job, keyword_init: true)
# Создаем конкретно пользователя и заполняем имя
user = User.new name: 'rob'
puts user.name


HexletCode.form_for