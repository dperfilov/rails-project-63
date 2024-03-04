# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag_name, params = {}, fields = [])
      unpaired = %w[area base br col embed hr img input link meta source track wbr]

      result = []
      result << '<'
      result << tag_name

      unless params.empty?
        params.each do |key, value|
          result << " #{key}=\"#{value}\""
        end
      end

      result << '>'
      result << yield if block_given?
      result << fields unless fields.empty?
      result << "</#{tag_name}>" unless unpaired.include? tag_name

      result.join
    end
  end
end
