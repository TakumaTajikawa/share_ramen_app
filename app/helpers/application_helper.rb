module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'シェアラー'
    if page_title.blank?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass}") do
      concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
      concat raw(message)
    end
  end
end
