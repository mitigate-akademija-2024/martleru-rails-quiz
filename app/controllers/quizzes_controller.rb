require 'csv'

class QuizzesController < ApplicationController
  include AuthorizesQuizAuthor
  include CheckIfQuizPublished
  before_action :authenticate_user!, except: %i[index show play_quiz submit_quiz results export_results search_quiz export_scores] 

  before_action :set_quiz, only: %i[show edit update destroy play_quiz submit_quiz results export_results publish export_scores]
  before_action :set_top_scores, only: %i[show export_scores]  
  before_action :set_quizzes, only: %i[index search_quiz]
  before_action :ensure_quiz_has_questions, only: %i[play_quiz submit_quiz results export_results]
  before_action :authorize_quiz_owner, only: %i[publish edit update]
  before_action :check_if_published, only: %i[edit update]

  def index
  end

  def show
    @testimonial = Testimonial.new
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user

    if @quiz.save
      redirect_to @quiz, notice: "Quiz was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to @quiz, notice: "Quiz was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @quiz.destroy
    redirect_to quizzes_url, notice: "Quiz was successfully deleted."
  end

  def play_quiz
  end

  def submit_quiz
    answers_params = params.fetch(:answers, {})
    score = 0
  
    @quiz.questions.each do |question|
      selected_answer_id = answers_params[question.id.to_s]
      answer = question.answers.find_by(id: selected_answer_id)
      score += 1 if answer&.correct
    end
  
    user = current_user || User.find_by(email: "anonymous@mitigate.dev")
  
    @user_score = UserScore.new(quiz: @quiz, user: user, score: score, answers: answers_params)
  
    if @user_score.save
      redirect_to results_attempt_quiz_path(@quiz, attempt_id: @user_score.id)
    else
      redirect_to play_quiz_path(@quiz), alert: "Your quiz attempt could not be saved."
    end
  end
  
  def results
    @user_score = UserScore.find_by(id: params[:attempt_id])
    if @user_score && @user_score.quiz_id == @quiz.id
      @questions = @quiz.questions.includes(:answers)
    else
      redirect_to play_quiz_path(@quiz), alert: "Results not found."
    end
  end
  
  def export_results
    @user_score = UserScore.find_by(quiz: @quiz)

    if @user_score
      csv_data = CSV.generate(headers: true) do |csv|
        csv << ['Question', 'Your Answer', 'Correct Answer', 'Correct?']

        @quiz.questions.each do |question|
          selected_answer_id = @user_score.answers[question.id.to_s]
          selected_answer = question.answers.find_by(id: selected_answer_id)
          correct_answer = question.answers.find_by(correct: true)
          
          csv << [
            question.question_text,
            selected_answer ? selected_answer.answer_text : 'N/A',
            correct_answer ? correct_answer.answer_text : 'N/A',
            selected_answer && selected_answer.correct ? 'Yes' : 'No'
          ]
        end
      end

      send_data csv_data, filename: "quiz_results_#{current_user&.id || 'anonymous'}_#{@quiz.id}.csv", type: 'text/csv'
    else
      redirect_to results_quiz_path(@quiz), alert: 'No results found for export.'
    end
  end

  def export_scores
    if @quiz.present? && @top_scores.present?
      csv_data = CSV.generate(headers: true) do |csv|
        csv << ['Username', 'Score', 'Date']
  
        @top_scores.each do |score|
          csv << [score.user.username, score.score, score.created_at]
        end
      end
  
      send_data csv_data, filename: "top_quiz_results_#{@quiz.id}.csv", type: 'text/csv'
    else
      redirect_to quizzes_path, alert: 'Quiz not found or no top results available for export.'
    end
  end

  def search_quiz
    if params[:title].present?
      @quizzes = @quizzes.where('title LIKE ?', "%#{params[:title]}%")
    end
    
    render :index
  end

  def publish
    @quiz.update(published: true)
    redirect_to @quiz, notice: "Your quiz has been published!"
  end

  private

  def set_quizzes
    @quizzes = Quiz.where(published: true)
  end

  def set_quiz
    @quiz = Quiz.find_by(id: params[:id])
  end

  def set_top_scores
    @top_scores = @quiz.user_scores.includes(:user).order(score: :desc).limit(10)
  end

  def ensure_quiz_has_questions
    unless @quiz.questions.exists?
      redirect_to quizzes_path, alert: "This quiz has no questions."
    end
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end
end

