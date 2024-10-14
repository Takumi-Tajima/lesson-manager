class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show]

  def index
    @lessons = Lesson.default_order.page(params[:page])
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end
