class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @quizzes = @user.quizzes.page(params[:quizzes_page]).per(5)  
    @results = @user.user_scores.page(params[:results_page]).per(5)  
  end
  
end
