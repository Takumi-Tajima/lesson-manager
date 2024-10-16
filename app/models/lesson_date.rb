class LessonDate < ApplicationRecord
  belongs_to :lesson
  has_many :reservations, dependent: :destroy

  validates :date, :start_at, :end_at, :url, presence: { message: '必須項目です' }
  validates :date, uniqueness: { scope: :lesson_id }, comparison: { greater_than: Date.current, message: '本日以降の日程を選択してください。' }
  validates :start_at, comparison: { greater_than: Time.current + 30.minutes, message: '開始時刻は、現時刻よりも30分以上間隔を開けて設定してください' }, if: :today?
  validates :end_at, comparison: { greater_than: :start_at, message: '終了時刻は、開始時刻よりも後に設定してください' }
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: '定員は1人から100人の間で設定してください' }

  scope :default_order, -> { order(:date) }

  def today?
    date == Date.current
  end
end
