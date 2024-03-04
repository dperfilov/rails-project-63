# frozen_string_literal: true

module HexletCode
  class FormRender
    def self.render_form(form_template)
      HexletCode::Tag.build('form', form_template.form_body[:form_options], form_template.form_body[:inputs])
    end
  end
end
