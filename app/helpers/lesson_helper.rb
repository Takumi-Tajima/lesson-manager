module LessonHelper
  def lesson_publish_label(lesson)
    label, css = lesson.publish? ? %w[公開 bg-primary] : %w[非公開 bg-secondary]
    tag.span label, class: "badge #{css}"
  end
end
