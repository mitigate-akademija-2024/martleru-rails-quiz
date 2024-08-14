class TestimonialsController < ApplicationController
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
  
  
    private
  
    def testimonial_params
      params.require(:testimonial).permit(:testimonial_text)
    end
  end
  