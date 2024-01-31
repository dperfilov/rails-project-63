module TagModule

	def build tag_name, params={}
	  # void elements area, base, br, col, embed, hr, img, input, link, meta, source, track, wbr
	  unpaired = ['br', 'hr', 'img', 'input', 'link']

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
	  result << "</#{tag_name}>" if !unpaired.include? tag_name

	  result.join
	end

end