class Api::V1::CustomUsersController < ApplicationController
  def index
    render json: User.select(:id, :email), status: :ok
  end
end
