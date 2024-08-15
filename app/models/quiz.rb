class Quiz < ApplicationRecord
  belongs_to :user
  
  has_many :questions, dependent: :destroy
  has_many :user_scores, dependent: :destroy
  has_many :testimonials, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validate :prevent_changes_if_published, on: :update

  before_validation :normalize_title
  before_save :normalize_description

  def owned_by?(user)
    self.user == user
  end

  protected

  def normalize_title
    self.title = title.to_s.squish.capitalize
  end

  def normalize_description
    self.description = description.to_s.squish
  end

  private

  def prevent_changes_if_published
    if published? && (title_changed? || description_changed?)
      errors.add(:base, "Cannot update quiz details once published")
    end
  end
end
