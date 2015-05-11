class AvailabilitiesController < ApplicationController
  before_action :load_user
  before_action :set_availability, only: [:destroy]
  before_action :current_user, except: [:index, :show]

  # GET /availabilities
  # GET /availabilities.json
  def index
    @availabilities = @user.availabilities
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
  	@availability = Availability.find(params[:id])
  end

  # GET /availabilities/new
  def new
    @availability = @user.availabilities.new
  end

  # GET /availabilities/1/edit
  def edit
  	@availability = Availability.find(params[:id])
  end

  # POST /availabilities
  # POST /availabilities.json
  def create
    @availability = @user.availabilities.new(availability_params)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to user_availabilities_path, notice: 'Availability was successfully created.' }
        format.json { render :show, status: :created, location: ([@user, @availability]) }
      else
        format.html { render :new }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /availabilities/1
  # PATCH/PUT /availabilities/1.json
  def update
  	@availability = Availability.find(params[:id])
    respond_to do |format|
      if @availability.update(availability_params)
        format.html { redirect_to ([@user, @availability]), notice: 'Availability was successfully updated.' }
        format.json { render :show, status: :ok, location: ([@user, @availability]) }
      else
        format.html { render :edit }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    @availability.destroy
    respond_to do |format|
      format.html { redirect_to user_availabilities_path, notice: 'Availability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def availability_params
      params.require(:availability).permit(:start_time, :end_time)
    end

    def load_user
    	@user = User.find(params[:user_id])
    end
end
