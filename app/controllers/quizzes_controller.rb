class QuizzesController < ApplicationController
  # Ensure user authentication for all actions except `index` and `show`
  # before_action :authenticate_user!, except: [:index, :show]
 before_action :set_quiz, only: %i[show edit update destroy play_quiz submit_quiz results]


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
        format.html do
          flash[:notice] = "Quiz was successfully created."
          redirect_to @quiz
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        flash.now[:alert] = @quiz.errors.full_messages.to_sentence
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
    score = 0
    answers_params = params.fetch(:answers, {})

    @quiz.questions.each do |question|
      selected_answer_id = answers_params[question.id.to_s]
      answer = question.answers.find_by(id: selected_answer_id)
      score += 1 if answer&.correct
    end

    user = current_user
    @user_score = UserScore.find_or_initialize_by(quiz: @quiz, user: user)

    if @user_score.update(score: score)
      redirect_to results_quiz_path(@quiz)
    else
      redirect_to play_quiz_path(@quiz), alert: "There was an error recording your score."
    end
  end

  def results
    @user_score = UserScore.find_by(quiz: @quiz, user: current_user) ||
                  UserScore.find_by(quiz: @quiz, user: nil)
    @questions = @quiz.questions.includes(:answers)
  end

  private

    # Set the quiz for actions requiring a quiz
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Strong parameters for quiz
    def quiz_params
      params.require(:quiz).permit(:title, :description)
    end
end
