class AddPublishedToQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_column :quizzes, :published, :boolean, default: false
  end
end
