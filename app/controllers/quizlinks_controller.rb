class QuizlinksController < ApplicationController
  before_action :set_quiz, only: [:create, :show]
  
    def show
    end

    def create
      emails = params[:emails].split(",").map(&:strip)
      QuizMailer.send_quiz_link(@quiz, emails).deliver_now
  
      flash[:notice] = "Quiz link sent successfully."
      redirect_to @quiz
    end

    private

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
  end
  