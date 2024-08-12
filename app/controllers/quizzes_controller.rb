class QuizzesController < ApplicationController
  # before_action :authenticate_user! 
  before_action :set_quiz, only: %i[ show edit update destroy ]

  def index
    @title = "Quick Quiz Challenge"
    @description = "Test your knowledge with our fun and engaging quizzes! Whether you're brushing up on trivia or challenging yourself with new topics, our quizzes are designed to be both educational and entertaining. Dive in and see how much you can score!"

    @quizzes = Quiz.all
  end

  def start
    @title = "Start quizzes"
    @description = "Lorem ipsum"

    respond_to do |format|
      format.html 
      format.json do 
        render json: {title: @title, description: @description, text: "This is Json"}
      end
    end
  end

  def show
  end

  def new
    @quiz = Quiz.new
  end

  def edit
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
  
    respond_to do |format|
      if @quiz.save
        format.html do
          flash.notice = "Quiz was successfully created."
          redirect_to quiz_url(@quiz)
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        flash.now.alert = @quiz.errors.full_messages.to_sentence
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!
    redirect_to quizzes_url, notice: "Quiz was successfully deleted."

    
    # You can respond to vaious formats. .json will send a json
    # respond_to do |format|
    #   format.html { redirect_to quizzes_url, notice: "Quiz was successfully deleted." }
    #   format.json { head :no_content }
    # end
  end

  private
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description)
    end
end
