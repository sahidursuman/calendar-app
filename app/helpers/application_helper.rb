module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | CalendarApp"
    end
  end

  
	# def put_end_time(start_time)
	# 	 (start_time.to_time + 1.hours).to_datetime
	# end



  
end
