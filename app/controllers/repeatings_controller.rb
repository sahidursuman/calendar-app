class RepeatingsController < ApplicationController
  before_action :load_instructor
  before_action :set_repeating, only: [:destroy]
  before_action :current_user, except: [:index, :show]

  def new
  @repeating = @instructor.repeatings.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  def index
  end


private
  def set_repeating
    @repeating = repeating.find(params[:id])
  end

  def repeating_params
    params.require(:repeating).permit(:start_time, :end_time)
  end

  def load_instructor
    @instructor = Instructor.find(params[:instructor_id])
  end
end
