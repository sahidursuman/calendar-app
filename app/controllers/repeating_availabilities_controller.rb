class RepeatingAvailabilitiesController < ApplicationController
  before_action :load_instructor
  before_action :set_repeating_availability, only: [:destroy]
  before_action :current_user, except: [:index, :show]

  # GET /repeating_availabilities
  # GET /repeating_availabilities.json
  def index
    @repeating_availabilities = @instructor.repeating_availabilities
  end

  # GET /repeating_availabilities/1
  # GET /repeating_availabilities/1.json
  def show
    @repeating_availability = repeating_availability.find(params[:id])
  end

  # GET /repeating_availabilities/new
  def new
    @repeating_availability = @instructor.repeating_availabilities.new
  end

  # GET /repeating_availabilities/1/edit
  def edit
    @repeating_availability = repeating_availability.find(params[:id])
  end

  # POST /repeating_availabilities
  # POST /repeating_availabilities.json
  def create
    @repeating_availability = @instructor.repeating_availabilities.build(availability_params)

    respond_to do |format|
      if @repeating_availability.save
        format.html { redirect_to :back, notice: 'repeating_availability was successfully created.' }
        format.json { render :show, status: :created, location: ([@instructor, @repeating_availability]) }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :new }
        format.json { render json: @repeating_availability.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /repeating_availabilities/1
  # PATCH/PUT /repeating_availabilities/1.json
  def update
    @repeating_availability = repeating_availability.find(params[:id])
    respond_to do |format|
      if @repeating_availability.update(availability_params)
        format.html { redirect_to ([@instructor, @repeating_availability]), notice: 'repeating_availability was successfully updated.' }
        format.json { render :show, status: :ok, location: ([@instructor, @repeating_availability]) }
      else
        format.html { render :edit }
        format.json { render json: @repeating_availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repeating_availabilities/1
  # DELETE /repeating_availabilities/1.json
  def destroy
    @repeating_availability.destroy
    respond_to do |format|
      format.html { redirect_to instructor_availabilities_path, notice: 'repeating_availability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repeating_availability
      @repeating_availability = repeating_availability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repeating_availability_params
      params.require(:repeating_availability).permit(:start_time, :end_time)
    end

    def load_instructor
      @instructor = Instructor.find(params[:instructor_id])
    end
end
end
