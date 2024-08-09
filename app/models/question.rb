class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  #dependent - izies cauri tiem visiem has_many - šajā gadījumā visām atbildēm kas piesaistītas jautājumam un nodzēsīs
  has_many :answers, dependent: :destroy
  
  accepts_nested_attributes_for :answers
end