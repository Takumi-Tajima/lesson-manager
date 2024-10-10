class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.string :name, null: false, default: '', limit: 50
      t.string :overview, null: false, default: '', limit: 100
      t.string :instructor, null: false, default: '', limit: 50
      t.boolean :hidden, null: false, default: false

      t.timestamps
    end
  end
end
