class ReservationsController < ApplicationController
  def create
    reservation = current_user.reservations.build(lesson_date_id: params[:lesson_date_id])
    if reservation.save!
      redirect_to lesson_lesson_dates_path(reservation.lesson_date.lesson), notice: t('controllers.reservations.created')
    end
  end

  def destroy
    reservation = current_user.reservations.find(params[:id])
    reservation.destroy!
    redirect_to my_reservations_path, notice: t('controllers.reservations.destroyed'), status: :see_other
  end
end
