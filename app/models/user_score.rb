class UserScore < ApplicationRecord
    belongs_to :quiz
    belongs_to :user, optional: true
  
  end
  