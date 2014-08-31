ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /<(label)/
    html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    html_field.children.add_class 'field-with-error'
    html_field.to_s.html_safe
  else
    html_tag
  end
end