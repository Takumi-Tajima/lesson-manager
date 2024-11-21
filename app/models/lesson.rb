class Lesson < ApplicationRecord
  has_many :lesson_dates, dependent: :restrict_with_error

  validates :name, presence: true
  validates :instructor, presence: true
  validates :overview, presence: true
  validates :publish, inclusion: { in: [true, false] }

  scope :default_order, -> { order(:created_at) }
  scope :publish, -> { where(publish: true) }
end
