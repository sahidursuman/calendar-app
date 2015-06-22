class ReviewsController < ApplicationController
  before_filter :load_instructor
  before_filter :ensure_logged_in, only: [:create, :destroy]

  def new
    @review = @instructor.reviews.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @instructor.reviews.build(review_params)
    @review.user = current_user
    load_instructor
    if @review.save
      redirect_to instructor_path(@instructor), notice: 'Review created successfully'
    else
      render 'reviews/show'
    end
  end

  def edit
  @review = Review.find(params[:id])
  load_instructor
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      redirect_to instructor_path(@instructor)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

 private
  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_instructor
    @instructor = Instructor.find(params[:instructor_id])
  end
end
