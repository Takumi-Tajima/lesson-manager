class LessonDate < ApplicationRecord
  belongs_to :lesson
  has_many :reservations, dependent: :restrict_with_error
  has_many :users, through: :reservations

  validates :date, uniqueness: { scope: :lesson_id }, comparison: { greater_than: Date.current }
  validates :start_at, comparison: { greater_than: Time.current + 30.minutes }, if: :today?
  validates :end_at, comparison: { greater_than: :start_at }
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validates :url, presence: true

  scope :default_order, -> { order(:date) }
  scope :reservable_lessons, -> { left_joins(:reservations).group('lesson_dates.id').having('COUNT(reservations.id) < lesson_dates.capacity') }

  def today?
    date == Date.current
  end
end
