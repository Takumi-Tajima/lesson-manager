class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_date

  scope :default_order, -> { order(:created_at) }

  validates :user_id, uniqueness: { scope: :lesson_date_id, message: '同じレッスンを同日に2つ以上予約することはできません' }
  validate :limit_of_reservation

  def limit_of_reservation
    if lesson_date.capacity <= lesson_date.reservations.count
      errors.add(:base, 'このレッスンは満員です')
    end
  end
end
