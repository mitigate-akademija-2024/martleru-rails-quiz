class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]
  before_action :set_question, only: [:destroy, :edit, :update]


  def index
  end

  def create
    @question = @quiz.questions.new(question_params)

    if @question.save
      flash.notice = "Question was successfully created."
      redirect_to quiz_url(@quiz)
    else
      @question.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @question = @quiz.questions.new
    @question.answers.new
  end

  def destroy
    @question.destroy!
    redirect_to quiz_path(@question.quiz), notice: "Deleted"
  end 

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to quiz_url(@question.quiz), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end 

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct, :_destroy])
  end
end