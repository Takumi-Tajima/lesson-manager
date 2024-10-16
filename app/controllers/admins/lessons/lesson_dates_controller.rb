class Admins::Lessons::LessonDatesController < Admins::ApplicationController
  before_action :set_lesson, only: %i[index new create]
  before_action :set_lesson_date, only: %i[show edit update destroy]

  def index
    lesson = set_lesson
    @lesson_dates = lesson.lesson_dates
  end

  def show
  end

  def new
    lesson = set_lesson
    @lesson_date = lesson.lesson_dates.build
  end

  def edit
  end

  def create
    lesson = set_lesson
    @lesson_date = lesson.lesson_dates.build(lesson_date_params)

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
    Lesson.find(params[:lesson_id])
  end

  def set_lesson_date
    @lesson_date = LessonDate.find(params[:id])
  end

  def lesson_date_params
    params.require(:lesson_date).permit(:date, :start_at, :end_at, :capacity, :url)
  end
end
