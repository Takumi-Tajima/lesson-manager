class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show]

  def index
    @lessons = Lesson.visible.default_order.page(params[:page])
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.visible.find(params[:id])
  end
end
