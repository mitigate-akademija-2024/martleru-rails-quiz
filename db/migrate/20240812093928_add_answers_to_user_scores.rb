class AddAnswersToUserScores < ActiveRecord::Migration[7.1]
  def change
    add_column :user_scores, :answers, :json
  end
end
