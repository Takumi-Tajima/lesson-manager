class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :lesson_date, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reservations, %i[user_id lesson_date_id], unique: true
  end
end
