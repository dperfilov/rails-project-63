# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/hexlet_code'

class HexletCodeTest < Minitest::Test
  def setup
    @expected_tags = {
      br: '<br>',
      img: '<img src="path/to/image">',
      input: '<input type="submit" value="Save">',
      label: '<label>Email</label>',
      label_for: '<label for="email">Email</label>',
      div: '<div></div>'
    }

    @expected_forms = {
      basic: '<form action="#" method="post"></form>',
      with_url: '<form action="/users" method="post"></form>'
    }

    @user = Struct.new(:name, :job, keyword_init: true)
    @user_rob = @user.new name: 'rob'

    @user_with_gender = Struct.new(:name, :job, :gender, keyword_init: true)
    @user_rob_with_gender = @user_with_gender.new name: 'rob', job: 'hexlet', gender: 'm'

    @user_hexlet = Struct.new(:name, :job, keyword_init: true)
    @user_hexlet = @user_hexlet.new job: 'hexlet'
  end

  def test_tags_builder
    assert { @expected_tags[:br] == HexletCode::Tag.build('br') }
    assert { @expected_tags[:input] == HexletCode::Tag.build('input', type: 'submit', value: 'Save') }
    assert { @expected_tags[:label] == HexletCode::Tag.build('label') { 'Email' } }
    assert { @expected_tags[:label_for] == HexletCode::Tag.build('label', for: 'email') { 'Email' } }
    assert { @expected_tags[:div] == HexletCode::Tag.build('div') }
  end

  def test_basic_form_generator
    # @user = Struct.new(:name, :job, keyword_init: true)
    # user = @user.new name: 'rob'

    # почему то не работает передача параметра user без скобок
    assert { @expected_forms[:basic] == HexletCode.form_for(@user_rob) }
    assert { @expected_forms[:with_url] == HexletCode.form_for(@user_rob, url: '/users') }
  end

  def test_form_1_with_fields
    result = HexletCode.form_for @user_rob_with_gender do |f|
      # Проверяет есть ли значение внутри name
      f.input :name
      # Проверяет есть ли значение внутри job
      f.input :job, as: :text
    end

    assert { result == read_html_fixture(__method__.to_s) }
  end

  # Для полей можно указать дополнительные атрибуты в виде хеша последним параметром
  def test_form_2_with_additional_attributes
    result = HexletCode.form_for @user_rob_with_gender, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    assert { result == read_html_fixture(__method__.to_s) }
  end

  # У полей могут быть дефолтные значения, которые можно переопределить
  def test_form_3_with_default_values
    result = HexletCode.form_for @user_rob_with_gender do |f|
      f.input :job, as: :text
    end

    assert { result == read_html_fixture(__method__.to_s) }
  end

  # пример с переопределением атрибутов rows and cols
  def test_form_4_with_default_values_override
    result = HexletCode.form_for @user_rob_with_gender, url: '#' do |f|
      f.input :job, as: :text, cols: 50, rows: 50
    end

    assert { result == read_html_fixture(__method__.to_s) }
  end

  def test_form_5_with_submit_button
    result = HexletCode.form_for @user_hexlet do |f|
      f.input :name
      f.input :job
      f.submit
    end

    assert { result == read_html_fixture(__method__.to_s) }
  end

  def test_form_6_with_submit_button_custom
    result = HexletCode.form_for @user_hexlet do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end

    assert { result == read_html_fixture(__method__.to_s) }
  end

  def read_html_fixture(file_name)
    # File.open("#{__dir__}/fixtures/#{file_name}.html").read.gsub(/\n/, '')

    File.read("#{__dir__}/fixtures/#{file_name}.html").gsub("\n", '')
  end
end
