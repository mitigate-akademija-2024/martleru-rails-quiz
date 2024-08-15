class Answer < ApplicationRecord
  validates :answer_text, presence: true

  belongs_to :question

  before_validation :normalize_answer_text

  protected

  def normalize_answer_text
    self.answer_text = answer_text.to_s.squish.capitalize
  end
end