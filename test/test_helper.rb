# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

require 'minitest/autorun'

def read_html_fixture(file_name)
  File.read("#{__dir__}/fixtures/#{file_name}.html").gsub("\n", '')
end
