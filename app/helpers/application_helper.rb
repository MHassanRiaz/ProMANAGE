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
end
