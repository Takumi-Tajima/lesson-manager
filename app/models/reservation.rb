class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_date

  scope :default_order, -> { order(:created_at) }

  validates :user_id, uniqueness: { scope: :lesson_date_id, message: '同じレッスンを同日に2つ以上予約することはできません' }
  validate :limit_of_reservation
  validate :no_overlapping_reservations

  def limit_of_reservation
    if lesson_date.capacity <= lesson_date.reservations.count
      errors.add(:base, 'このレッスンは満員です')
    end
  end

  # def same_date
  #   user.lesson_dates.each do |booked_lesson_date|
  #     next unless lesson_date.date == booked_lesson_date.date

  #     errors.add(:base, '同じ日程です')
  #   end
  # end

  # def overlapping
  #   user.lesson_dates.each do |lesson_date_reserved|
  #     next unless (lesson_date_reserved.start_at..lesson_date_reserved.end_at).overlap?(lesson_date.start_at..lesson_date.end_at)

  #     errors.add(:base, 'すでに同じ時刻に予約をしています。')
  #   end
  # end

  def no_overlapping_reservations
    if dates_overlap?(user.lesson_dates) && times_overlap?(user.lesson_dates)
      errors.add(:base, 'すでに同じ時刻に予約をしています。')
    end
  end

  def dates_overlap?(lesson_dates = nil)
    return false unless lesson_dates

    lesson_dates.each do |lesson_date_reserved|
      if lesson_date_reserved.date == lesson_date.date
        return true
      end
    end
  end

  def times_overlap?(lesson_dates = nil)
    return false unless lesson_dates

    lesson_dates.each do |lesson_date_reserved|
      if (lesson_date_reserved.start_at..lesson_date_reserved.end_at).overlap?(lesson_date.start_at..lesson_date.end_at)
        return true
      end
    end
  end
end
