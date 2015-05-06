module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | CalendarApp"
    end
  end
end
