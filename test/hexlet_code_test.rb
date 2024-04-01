  # frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/hexlet_code'

class HexletCodeTest < Minitest::Test
  def setup
    @user = Struct.new(:name, :job, keyword_init: true)
    @user_rob = @user.new name: 'rob'

    @user_with_gender = Struct.new(:name, :job, :gender, keyword_init: true)
    @user_rob_with_gender = @user_with_gender.new name: 'rob', job: 'hexlet', gender: 'm'

    @user_hexlet = Struct.new(:name, :job, keyword_init: true)
    @user_hexlet = @user_hexlet.new job: 'hexlet'

    @test_form_basic = read_html_fixture('test_form_basic')
    @test_form_basic_with_url = read_html_fixture('test_form_basic_with_url')
    @test_form_1_with_fields = read_html_fixture('test_form_1_with_fields')
    @test_form_2_with_additional_attributes = read_html_fixture('test_form_2_with_additional_attributes')
    @test_form_3_with_default_values = read_html_fixture('test_form_3_with_default_values')
    @test_form_4_with_default_values_override = read_html_fixture('test_form_4_with_default_values_override')
    @test_form_5_with_submit_button = read_html_fixture('test_form_5_with_submit_button')
    @test_form_6_with_submit_button_custom = read_html_fixture('test_form_6_with_submit_button_custom')
  end

  def test_form_basic
    result = HexletCode.form_for(@user_rob)

    assert { result == @test_form_basic }
  end

  def test_form_basic_with_url
    result = HexletCode.form_for(@user_rob, url: '/users')

    assert { result == @test_form_basic_with_url }
  end

  def test_form_1_with_fields
    result = HexletCode.form_for @user_rob_with_gender do |f|
      f.input :name
      f.input :job, as: :text
    end

    assert { result == @test_form_1_with_fields }
  end

  def test_form_2_with_additional_attributes
    result = HexletCode.form_for @user_rob_with_gender, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    assert { result == @test_form_2_with_additional_attributes }
  end

  def test_form_3_with_default_values
    result = HexletCode.form_for @user_rob_with_gender do |f|
      f.input :job, as: :text
    end

    assert { result == @test_form_3_with_default_values }
  end

  def test_form_4_with_default_values_override
    result = HexletCode.form_for @user_rob_with_gender, url: '#' do |f|
      f.input :job, as: :text, cols: 50, rows: 50
    end

    assert { result == @test_form_4_with_default_values_override }
  end

  def test_form_5_with_submit_button
    result = HexletCode.form_for @user_hexlet do |f|
      f.input :name
      f.input :job
      f.submit
    end

    assert { result == @test_form_5_with_submit_button }
  end

  def test_form_6_with_submit_button_custom
    result = HexletCode.form_for @user_hexlet do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end

    assert { result == @test_form_6_with_submit_button_custom }
  end
end
