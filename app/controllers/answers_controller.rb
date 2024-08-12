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
        flash.now.alert = @question.errors.full_messages.to_sentence
      end 
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
  