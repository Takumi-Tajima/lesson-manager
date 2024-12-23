class Admins::Lessons::LessonDatesController < Admins::ApplicationController
  before_action :set_lesson
  before_action :set_lesson_date, only: %i[show edit update destroy]

  def index
    @lesson_dates = @lesson.lesson_dates.default_order.page(params[:page])
  end

  def show
  end

  def new
    @lesson_date = @lesson.lesson_dates.build
  end

  def edit
  end

  def create
    @lesson_date = @lesson.lesson_dates.build(lesson_date_params)

    if @lesson_date.save
      redirect_to admins_lesson_lesson_dates_path(@lesson_date.lesson), notice: t('controllers.common.created', model: '開催日')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @lesson_date.update(lesson_date_params)
      redirect_to admins_lesson_lesson_date_path(@lesson_date.lesson, @lesson_date), notice: t('controllers.common.updated', model: '開催日'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson_date.destroy!
    redirect_to admins_lesson_lesson_dates_path(@lesson_date.lesson), notice: t('controllers.common.destroyed', model: '開催日'), status: :see_other
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_lesson_date
    @lesson_date = @lesson.lesson_dates.find(params[:id])
  end

  def lesson_date_params
    params.require(:lesson_date).permit(:date, :start_at, :end_at, :capacity, :url)
  end
end
