install: # установить зависимости
	bundle install

lint:
	rubocop --fail-level=error

tests: