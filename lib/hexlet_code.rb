# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end


  class Tag
    def self.build tag_name, **params
      paired = ['label', 'div']

      result = []
      result << '<'
      result << tag_name

      # add attributes from hash
      params.each do |key, value|
        result << " #{key}=\"#{value}\""
      end if !params.empty?

      result << '>'

      # add body from given block
      if block_given?
        result << yield
      end

      # for paired tags add closing part
      result << "</#{tag_name}>" if paired.include? tag_name

      result.join
    end
  end
end