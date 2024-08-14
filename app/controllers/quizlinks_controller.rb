class QuizlinksController < ApplicationController
  
    def show
      @quiz = Quiz.find(params[:quiz_id])
    end

    def create

    end
  end
  