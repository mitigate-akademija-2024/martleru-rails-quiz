class QuizMailer < ApplicationMailer

    def share
        @quiz = Quiz.find(params[:quiz_id])
    end
end
