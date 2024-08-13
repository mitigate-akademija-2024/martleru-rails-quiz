module QuizzesHelper
  def user_answer_status(user_score, question, answer)
    return { selected: false, correct: false } unless user_score && user_score.answers.present?

    selected_answer_id = user_score.answers[question.id.to_s]
    is_selected = (answer.id.to_s == selected_answer_id)
    is_correct = answer.correct

    { selected: is_selected, correct: is_correct }
  end
end
