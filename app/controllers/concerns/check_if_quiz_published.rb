module  
    extend ActiveSupport::Concern

    def check_if_published
        if @quiz.published
            redirect_to quizzes_path, alert: "This quiz has already been published."
        end
    end
end

