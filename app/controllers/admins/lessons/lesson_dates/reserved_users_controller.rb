class Admins::Lessons::LessonDates::ReservedUsersController < Admins::ApplicationController
  def index
    lesson = Lesson.find(params[:lesson_id])
    lesson_date = lesson.lesson_dates.find(params[:lesson_date_id])
    @users = lesson_date.users.default_order
  end
end
