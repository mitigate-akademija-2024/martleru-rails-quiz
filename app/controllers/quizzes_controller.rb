class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[show edit update destroy play_quiz submit_quiz results export_results]
  before_action :ensure_quiz_has_questions, only: [:play_quiz, :submit_quiz, :results, :export_results]
  before_action :authenticate_user!, except: [:index, :show, :play_quiz, :submit_quiz, :results, :export_results]

  # GET /quizzes
  def index
    @title = "Quick Quiz Challenge"
    @description = "Test your knowledge with our fun and engaging quizzes! Whether you're brushing up on trivia or challenging yourself with new topics, our quizzes are designed to be both educational and entertaining. Dive in and see how much you can score!"

    @quizzes = Quiz.all
  end

  # GET /quizzes/:id/play
  def play_quiz
  end

  # GET /quizzes/:id
  def show
    @user_scores = @quiz.user_scores.includes(:user) 
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/:id/edit
  def edit
  end

  # POST /quizzes
  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: "Quiz was successfully created." }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/:id
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/:id
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully deleted." }
      format.json { head :no_content }
    end
  end

  # POST /quizzes/:id/submit_quiz
  def submit_quiz
    answers_params = params.fetch(:answers, {})
    score = 0
  
    @quiz.questions.each do |question|
      selected_answer_id = answers_params[question.id.to_s]
      answer = question.answers.find_by(id: selected_answer_id)
      score += 1 if answer&.correct
    end
  
    user = current_user || find_anonymous_user
  
    @user_score = UserScore.new(quiz: @quiz, user: user, score: score, answers: answers_params)
  
    if @user_score.save
      redirect_to results_attempt_quiz_path(@quiz, attempt_id: @user_score.id)
    else
      redirect_to play_quiz_path(@quiz), alert: "There was an error recording your score."
    end
  end
  
  # GET /quizzes/:id/results
  def results
    @user_score = UserScore.find_by(id: params[:attempt_id])
    if @user_score && @user_score.quiz_id == @quiz.id
      @questions = @quiz.questions.includes(:answers)
    else
      redirect_to play_quiz_quiz_path(@quiz), alert: "Results not found."
    end
  end
  
  # GET /quizzes/:id/export_results
  def export_results
    @user_score = UserScore.find_by(quiz: @quiz, user: current_user)

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

      send_data csv_data, filename: "quiz_results_#{current_user.id}_#{@quiz.id}.csv", type: 'text/csv'
    else
      redirect_to results_quiz_path(@quiz), alert: 'No results found for export.'
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to quizzes_path, alert: "Quiz not found."
  end

  def find_anonymous_user
    User.find_by(email: "anonymous@mitigate.dev")
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
