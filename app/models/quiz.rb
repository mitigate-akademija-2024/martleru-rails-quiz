class Quiz < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  before_validation :normalize_title
  before_save :normalize_description

  has_many :questions, dependent: :destroy
  has_many :user_scores, dependent: :destroy
  has_many :testimonials, dependent: :destroy

  belongs_to :user

  validates :title, presence: true, uniqueness: true, on: :create
  validates :description, presence: true, on: :create

  validate :prevent_changes_if_published, on: :update

  def owned_by?(user)
    self.user == user
  end

  protected

  def normalize_title
    Rails.logger.info("Quiz#normalize_title called")
    self.title = title.to_s.squish.capitalize
  end

  def normalize_description
    Rails.logger.info("Quiz#normalize_description called")
    self.description = description.to_s.squish
  end

  private

  def prevent_changes_if_published
    if published? && (title_changed? || description_changed?)
      errors.add(:base, "Cannot update quiz details once published")
    end
  end
end
