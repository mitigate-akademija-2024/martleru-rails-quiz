class AnswerController < ApplicationController
    before_action :set_quiz, only: [:new, :create]
  
    def index
    end

    def show
    end

    def create
      @question = @quiz.questions.new(question_params)
  
      if @question.save
        flash.notice = "Something"
        redirect_to quiz_url(@quiz)
      else
  
      end 
    end
  
    def new
      @question = @quiz.questions.new
    end
  
    def set_answer
        puts "set_answers metode"
        @answer = Answer.find(params[:quiz_id])
    end
  
    def question_params
      params.require(:question).permit(:question_text)
    end
  end
  