class QuestionsController < ApplicationController
  def show
    @question = Question.find_by_qhash(params[:id])
    redirect_to "/404.html"    if @question.nil?
  end
  
end
