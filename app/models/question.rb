class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['answer_text'].blank? }
  
  validates :question_text, presence: true
  validate :validate_answers

  def validate_answers
    unless answers.any?(&:correct?)
      errors.add(:answers, :no_correct, message: "At least one answer must be correct")
    end
  end
  
end

#dependent - izies cauri tiem visiem has_many - šajā gadījumā visām atbildēm kas piesaistītas jautājumam un nodzēsīs



