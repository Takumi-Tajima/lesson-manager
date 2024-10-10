class Lesson < ApplicationRecord
  validates :name, presence: true
  validates :name, :instructor, length: { maximum: 50 }
  validates :overview, length: { maximum: 100 }
  validates :hidden, inclusion: { in: [true, false] }

  scope :default_order, -> { order(:created_at) }
end
