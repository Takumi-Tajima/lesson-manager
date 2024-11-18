class ChangeColumnToLessons < ActiveRecord::Migration[7.2]
  def change
    change_column :lessons, :name, :string, limit: false
    change_column :lessons, :overview, :string, limit: false
    change_column :lessons, :instructor, :string, limit: false
  end
end
