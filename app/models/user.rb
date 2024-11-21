class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, dependent: :destroy
  has_many :lesson_dates, through: :reservations

  scope :default_order, -> { order(:id) }
end
