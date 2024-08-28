module TasksHelper
  def status_color(status)
    case status
    when "not started"
      "primary"  # Blue color
    when "in progress"
      "secondary"  # Grey color
    when "completed"
      "success"  # Green color
    when "delayed"
      "danger"  # Red color
    else
      "secondary"  # Default fallback
    end
  end
end



