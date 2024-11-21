class Users::Lessons::LessonDates::ReservationsController < ApplicationController
  def create
    current_user.reservations.create!(lesson_date_id: params[:lesson_date_id])
    redirect_to reservations_path, notice: t('controllers.reservations.created')
  end

  def destroy
    reservation = current_user.reservations.find(params[:reservation_id])
    reservation.destroy!
    redirect_to reservations_path, notice: t('controllers.reservations.destroyed'), status: :see_other
  end
end
