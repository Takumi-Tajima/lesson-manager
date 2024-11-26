class Users::LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show]

  def index
    @lessons = Lesson.publish.default_order.page(params[:page])
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.publish.find(params[:id])
  end
end
