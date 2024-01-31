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

		# User = Struct.new(:name, :job, keyword_init: true)
		# @user = User.new name: 'rob'
	end

	def test_tags_builder
		assert { @expected_tags[:br] == HexletCode::Tag.build('br') }
		assert { @expected_tags[:input] == HexletCode::Tag.build('input', type: 'submit', value: 'Save') }
		assert { @expected_tags[:label] == HexletCode::Tag.build('label') { 'Email' } }
		assert { @expected_tags[:label_for] == HexletCode::Tag.build('label', for: 'email') { 'Email' } }
		assert { @expected_tags[:div] == HexletCode::Tag.build('div') }
	end

	def test_basic_form_generator
		@User = Struct.new(:name, :job, keyword_init: true)
		user = @User.new name: 'rob'

		# почему то не работает передача параметра user без скобок
		assert { @expected_forms[:basic] == HexletCode.form_for(user) { |f| } }
		assert { @expected_forms[:with_url] == HexletCode.form_for(user, url: '/users') { |f| } }
	end
end