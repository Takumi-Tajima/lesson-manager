class Users::Lessons::LessonDates::ReservationsController < ApplicationController
  def create
    reservation = current_user.reservations.create!(lesson_date_id: params[:lesson_date_id])
    redirect_to reservations_path, notice: t('controllers.reservations.created')

    AdminMailer.with(user: current_user, lesson: reservation.lesson_date.lesson,
                     lesson_date: reservation.lesson_date).lesson_reserved_notification.deliver_later
  end

  def destroy
    reservation = current_user.reservations.find(params[:reservation_id])
    reservation.destroy!
    redirect_to reservations_path, notice: t('controllers.reservations.destroyed'), status: :see_other
  end
end
