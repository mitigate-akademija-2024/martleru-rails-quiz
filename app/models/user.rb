class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_username, on: :create

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }

  has_many :quizzes, dependent: :destroy
  has_many :user_scores, dependent: :destroy
  has_many :testimonials, dependent: :destroy
  private

  def set_default_username
    self.username ||= email
  end
end

