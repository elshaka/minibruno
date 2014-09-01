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
    if url.include? controller_name or (url == root_path and controller_name == 'dashboard')
      options[:class] = 'active'
    end
    content_tag :li do
      link_to url, options do
        content_tag(:i, nil, class: "fa fa-#{icon} fa-fw") + " #{content}"
      end
    end
  end
end
