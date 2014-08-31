module ApplicationHelper
  def bootstrap_alert_for(flash_type)
    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-warning'
      when 'notice'
        'alert-info'
      else
        "alert-#{flash_type.to_s}"
    end
  end

  def navbar_menu_item(content, icon, url, options = {})
    options[:class] = 'active' if url.include? controller_name or (url == root_path and controller_name == 'dashboard')
    content_tag(:li, link_to(content_tag(:i, nil, class: "fa fa-#{icon} fa-fw") + " #{content}", url, options))
  end
end