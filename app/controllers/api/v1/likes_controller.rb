module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_user!

      def destroy
        Likes::PusherService.new(params[:photo_id], current_user).destroy
        render json: { message: 'Successfully unlike' }, status: :ok
      end

      def create
        like = Likes::PusherService.new(params[:photo_id], current_user).create
        render json: { like: like }
      end

      def status
        status = Likes::PusherService.new(params[:photo_id], current_user).already_like?
        render json: { status: status }
      end
    end
  end
end
