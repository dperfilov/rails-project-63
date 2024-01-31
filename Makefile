install: # установить зависимости
	bundle install

lint:
	rubocop --fail-level=error

tests:
	ruby test/hexlet_code_test.rb