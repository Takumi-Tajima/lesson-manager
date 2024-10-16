class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_date
end
