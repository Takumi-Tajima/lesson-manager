class MyReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations.default_order.page(params[:page])
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end
end
