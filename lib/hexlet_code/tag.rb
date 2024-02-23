# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag_name, params = {}, fields = [])
      # void elements area, base, br, col, embed, hr, img, input, link, meta, source, track, wbr
      unpaired = %w[br hr img input link]

      result = []
      result << '<'
      result << tag_name

      # add attributes from hash
      unless params.empty?
        params.each do |key, value|
          result << " #{key}=\"#{value}\""
        end
      end

      result << '>'

      # add body from given block
      result << yield if block_given?

      # add fields as form content
      result << fields unless fields.empty?

      # for paired tags add closing part
      result << "</#{tag_name}>" unless unpaired.include? tag_name

      result.join
    end
  end
end
