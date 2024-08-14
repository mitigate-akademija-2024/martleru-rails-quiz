module AuthorizesQuizAuthor
    extend ActiveSupport::Concern

    def authorize_quiz_owner
        unless @quiz.user == current_user
          flash[:alert] = "You are not authorized to #{action_name} this quiz"
          redirect_to root_path
        end
    end
end