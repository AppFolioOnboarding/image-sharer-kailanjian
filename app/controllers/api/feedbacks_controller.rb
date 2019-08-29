module Api
  class FeedbacksController < ApplicationController
    def create
      @feedback = Feedback.new(params.require(:feedback).permit(:name, :comments))
      if @feedback.save
        render json: @feedback.to_json, status: :created
      else
        head(:unprocessable_entity)
      end
    end
  end
end
