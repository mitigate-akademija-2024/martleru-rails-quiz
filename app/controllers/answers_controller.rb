class AnswerController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
    end

    def create
      @question = @quiz.questions.new(question_params)
      @user = current_user
    end
  
    def new
      @question = @quiz.questions.new
    end
  
    def question_params
      params.require(:question).permit(:question_text)
    end
  end
  