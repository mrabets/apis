module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_user!

      def destroy
        Likes::PusherService.new(params[:photo_id], current_user).destroy
        
        SendVisitsJob.perform_later('Unlike', 'Belarus')

        render json: { message: 'Successfully unlike' }, status: :ok
      end

      def create
        like = Likes::PusherService.new(params[:photo_id], current_user).create

        SendVisitsJob.perform_later('Like', 'Belarus')

        render json: { like: like }
      end

      def status
        status = Likes::PusherService.new(params[:photo_id], current_user).already_like?
        render json: { status: status }
      end
    end
  end
end
