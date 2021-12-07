class Api::V1::LikesController < ApplicationController
  before_action :authorized

  def destroy
    Likes::PusherService.new(params[:photo_id], @user).destroy
    render json: { message: 'Successfully unlike' }, status: :ok
  end

  def create
    like = Likes::PusherService.new(params[:photo_id], @user).create
    render json: { like: like }
  end
end
