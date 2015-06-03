class BookingsController < ApplicationController
  before_action :load_instructor
  
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    # @booking.instructor = 
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end

  def load_instructor
    @instructor = Instructor.find(params[:instructor_id])
  end
end
