class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:destroy]

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @testimonial = @quiz.testimonials.build(testimonial_params)

    if current_user
      @testimonial.user = current_user
    else
      @testimonial.user = User.find(5) 
    end

    if @testimonial.save
      redirect_to @quiz, notice: 'Testimonial was successfully created.'
    else
      render 'quizzes/show'
    end
  end

  def destroy
    if @testimonial.user == current_user
      @testimonial.destroy
      redirect_to user_path(current_user), notice: "Testimonial was successfully deleted."
    else
      redirect_to user_path(current_user), alert: 'You are not authorized to delete this testimonial.'
    end
  end
  

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:testimonial_text)
  end
end
