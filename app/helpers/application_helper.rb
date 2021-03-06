module ApplicationHelper

  def bootstrap_class_for flash_type
    classes = {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.with_indifferent_access

    classes[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{ bootstrap_class_for(msg_type) } fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def countdown_to(datetime)
    content_tag(:div, '', 'data-countdown' => datetime )
  end

  def resource_errors_top(resource)
    render partial: 'layouts/errors_top', locals: { resource: resource }
  end

end
