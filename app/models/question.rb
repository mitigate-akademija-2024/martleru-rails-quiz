class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  #dependent - izies cauri tiem visiem has_many - šajā gadījumā visām atbildēm kas piesaistītas jautājumam un nodzēsīs
  has_many :answers, dependent: :destroy
  
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['answer_text'].blank? }

  # validate :validate_answers

  # def validate_answers
  #   if answers.count < 2
  #     errors.add(:answers, :too_few, message: "At least two answers are needed")
  #   end
  
  #   unless answers.any?(&:correct?)
  #     errors.add(:answers, :no_correct, message: "At least one answer must be correct")
  #   end
  # end
  
end


