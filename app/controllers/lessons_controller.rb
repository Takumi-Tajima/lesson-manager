class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy ]

  # GET /lessons
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to @lesson, notice: "Lesson was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lessons/1
  def update
    if @lesson.update(lesson_params)
      redirect_to @lesson, notice: "Lesson was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy!
    redirect_to lessons_url, notice: "Lesson was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:name, :overview, :capacity, :Instructor_name, :hidden)
    end
end
