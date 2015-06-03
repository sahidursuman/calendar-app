class BookingsController < ApplicationController
  before_action :load_instructor
  
  def new
    @booking = Booking.new
  end

  def create
    @booking = @instructor.bookings.new(booking_params)
    @user = current_user
    @booking.student_id = @user.id
    @booking.teacher = @instructor

    respond_to do |format|
      if @booking.save
        format.html { redirect_to instructor_bookings_path, notice: 'booking was successfully created.' }
        format.json { render :show, status: :created, location: ([@instructor, @booking]) }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @bookings = @instructor.bookings
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
