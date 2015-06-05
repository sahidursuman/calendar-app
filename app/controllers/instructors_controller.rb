class InstructorsController < ApplicationController
  
  def index
		@instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find(params[:id])
    @availabilities = @instructor.availabilities
    @first_name = @instructor.teacher.first_name.capitalize
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
    @instructor.teacher = current_user
    if @instructor.save
      redirect_to instructors_url
    else
      render :new
    end
  end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
    if @instructor.update_attributes(instructor_params)
      redirect_to instructor_path(@instructor)
    else
      render :edit
    end
  end

  def destroy
  end

private

  def instructor_params
    params.require(:instructor).permit(:description, :first_language, :subject_to_teach, :education, :price_cents, :skype, :avatar, :avatar_cache, :remove_avatar, 
    	:resume, :resume_cache, :remove_resume, :credential, :credential_cache, :remove_credential, :credential_extra, :credential_extra_cache, :remove_credential_extra)
  end

end
