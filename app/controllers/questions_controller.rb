class QuestionsController < ApplicationController
  include AuthorizesQuizAuthor
  include CheckIfQuizPublished
  
  before_action :set_quiz, only: [:new, :create, :index, :edit, :update]
  before_action :set_question, only: [:destroy, :edit, :update]
  before_action :authenticate_user!
  before_action :authorize_quiz_owner, only: [:new, :create, :edit, :update, :index]
  before_action :check_if_published, only: %i[edit update create new destroy]

  def index
  end

  def create
    @question = @quiz.questions.new(question_params)

    if @question.save
      flash[:notice] = "Question successfully created."
      redirect_to quiz_questions_path(@quiz)
    else
      flash.now[:alert] = @question.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @question = @quiz.questions.new
    @question.answers.new
  end

  def destroy
    @question.destroy
    redirect_to quiz_path(@question.quiz), notice: "Question successfully deleted."
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:notice] = "Question successfully updated."
      redirect_to quiz_url(@question.quiz)
    else
      flash.now[:alert] = @question.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id]) if params[:quiz_id]
  end

  def set_question
    @question = Question.find(params[:id])
    @quiz = @question.quiz
  end

  def question_params
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct, :_destroy])
  end
end
