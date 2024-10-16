class Lesson < ApplicationRecord
  has_many :lesson_dates, dependent: :destroy

  validates :name, presence: { message: '必須項目です' }
  validates :name, :instructor, length: { maximum: 50, message: '50文字以内で入力してください' }
  validates :overview, length: { maximum: 100, message: '100文字以内で入力してください' }
  validates :publish, inclusion: { in: [true, false] }

  scope :default_order, -> { order(:created_at) }
  scope :visible, -> { where(publish: true) }
end
