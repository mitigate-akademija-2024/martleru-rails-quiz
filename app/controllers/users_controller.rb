class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @quizzes = @user.quizzes
    @results = @user.user_scores
  end
end
