# app/helpers/application_helper.rb
module ApplicationHelper
  # Converts flash message types to Bootstrap alert classes
  def flash_class(type)
    case type
    when "notice"
      "success"   # Bootstrap class for success messages
    when "alert"
      "danger"    # Bootstrap class for error messages
    when "error"
      "danger"    # Bootstrap class for error messages
    else
      "info"      # Default class for other flash messages
    end
  end
  module ApplicationHelper
    def status_color(status)
      case status
      when "not started"
        "text-primary"  # Blue color
      when "in progress"
        "text-secondary"  # Grey color
      when "completed"
        "text-success"  # Green color
      when "delayed"
        "text-danger"  # Red color
      else
        ""
      end
    end
  end

end
