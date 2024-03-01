# Status
![hexlet-check](https://github.com/dperfilov/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/dperfilov/rails-project-63)

# HexletCode

Simple gem for form generation.

## Installation


Install the gem and add to the application's Gemfile by executing:

    gem 'hexlet_code'

Run the following command to install it:

    bundle install


## Usage

Sample usage:

    User = Struct.new(:name, :job, :gender, keyword_init: true)
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end

    HexletCode.form_for user, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    HexletCode.form_for user, url: '#' do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dperfilov/rails-project-63.
