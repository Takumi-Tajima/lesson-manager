class Users::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations.preload(lesson_date: :lesson).default_order.page(params[:page])
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end
end
