class AdminMailer < ApplicationMailer
  default to: -> { Admin.pluck(:email) }

  def lesson_reserved_notification
    @user = params[:user]
    @lesson = params[:lesson]
    @lesson_date = params[:lesson_date]
    mail
  end
end
