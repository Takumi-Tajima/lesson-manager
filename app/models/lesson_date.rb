class LessonDate < ApplicationRecord
  belongs_to :lesson

  validates :date, :start_at, :end_at, :url, presence: { message: '必須項目です' }
  validates :date, uniqueness: { scope: :lesson_id }, comparison: { greater_than: Date.current, message: 'レッスン日は、本日以降の日程を選択してください。' }
  validates :start_at, comparison: { greater_than: Time.current + 30.minutes, message: 'レッスンの開始時刻は、現時刻よりも30分以上間隔を開けて設定してください' }, if: :today?
  validates :end_at, comparison: { greater_than: :start_at, message: 'レッスンの終了時刻は、開始時刻よりも後に設定してください' }
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: 'レッスンの定員は1人から100人の間で設定してください' }

  def today?
    date == Date.current
  end
end
