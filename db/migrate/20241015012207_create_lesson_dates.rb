class CreateLessonDates < ActiveRecord::Migration[7.2]
  def change
    create_table :lesson_dates do |t|
      t.references :lesson, null: false, foreign_key: true
      t.date :date, index: false, null: false
      t.time :start_at, null: false
      t.time :end_at, null: false
      t.integer :capacity, null: false, default: 1
      t.string :url, null: false, default: ''

      t.timestamps
    end
    add_index :lesson_dates, %i[lesson_id date], unique: true
  end
end
