class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @
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

  def find_availability
    availabilities = Availability.all.wherez
  end
end
