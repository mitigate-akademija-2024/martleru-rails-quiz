class AnswerController < ApplicationController
    before_action :set_quiz, only: [:new, :create]
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
  
    def set_answer
        @answer = Answer.find(params[:quiz_id])
    end
  
    def question_params
      params.require(:question).permit(:question_text)
    end
  end
  