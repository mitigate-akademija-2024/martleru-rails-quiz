class Answer < ApplicationRecord
  belongs_to :question
  
  validates :answer_text, presence: true

  before_validation :normalize_answer_text

  protected

  def normalize_answer_text
    self.answer_text = answer_text.to_s.squish.capitalize
  end
end
