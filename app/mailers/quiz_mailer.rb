class QuizMailer < ApplicationMailer
    default from: 'no-reply@example.com' 
  
    def send_quiz_link(quiz, emails)
        @quiz = quiz
        @url = play_quiz_quiz_url(@quiz)
    
        emails.each do |email|
          mail(to: email, subject: 'Your Quiz Link') do |format|
            format.text { render plain: "Please complete the quiz using the following link: #{@url}" }
            format.html { render 'send_quiz_link' }
          end
        end
      end
  end
  