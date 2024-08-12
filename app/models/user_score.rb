class UserScore < ApplicationRecord
    belongs_to :quiz
    belongs_to :user, optional: true
  
    before_save :ensure_answers_is_hash
    
    validates :answers, presence: true
    private
  
    def ensure_answers_is_hash
      self.answers ||= {}
    end
  end
  