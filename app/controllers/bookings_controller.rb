class BookingsController < ApplicationController
  before_action :load_instructor
  
  def new
    @booking = @instructor.bookings.new
  end

  def create
    @booking = @instructor.bookings.build(booking_params)
    # binding.pry
    @user = current_user
    @booking.student_id = @user.id
    @booking.instructor = @instructor
    @booking.end_time = put_end_time(@booking.start_time)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to instructor_path(@instructor), notice: 'booking was successfully created.' }
        format.json { render :show, status: :created, location: ([@instructor, @booking]) }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
        format.js {}
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

	def put_end_time(start_time)
		 (start_time.to_time + 1.hours).to_datetime
	end


  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end

  def load_instructor
    @instructor = Instructor.find(params[:instructor_id])
  end
end
