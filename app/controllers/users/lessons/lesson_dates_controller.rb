class Users::Lessons::LessonDatesController < ApplicationController
  def index
    lesson = Lesson.find(params[:lesson_id])
    @lesson_dates = lesson.lesson_dates.reservable_lessons.default_order.page(params[:page])
  end
end
