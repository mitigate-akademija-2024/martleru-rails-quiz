class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :answer_text, null: false
      t.boolean :correct, null: false, default: false
      #short-hand for references
      t.belongs_to :question, foreign_key: true

      t.timestamps
    end

    # add_reference :answers, :questions, foreign_key: true
  end
end
