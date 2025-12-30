module ApplicationHelper
  def task_status_class(status)
    case status
    when 'todo'
      'secondary'
    when 'doing'
      'warning'
    when 'done'
      'success'
    else
      'light'
    end
  end
end 