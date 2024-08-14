class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    # Eager loadings lai nepārkaptu N+1
    @user = User.includes(:quizzes, :user_scores, :testimonials).find(current_user.id)
    
    @quizzes = @user.quizzes.page(params[:quizzes_page]).per(5)
    @results = @user.user_scores.page(params[:results_page]).per(5)
    @testimonials = @user.testimonials
  end
end
