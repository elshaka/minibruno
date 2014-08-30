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
    content_tag(:li, link_to(content_tag(:i," #{content}", class: "fa fa-#{icon} fa-fw"), url, options))
  end
end