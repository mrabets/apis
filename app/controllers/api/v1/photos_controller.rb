module Api
  module V1
    class PhotosController < ApplicationController
      before_action :authenticate_user!

      def index
        photos = Photo.all.order(:updated_at)

        render json: photos
      end

      def create
        photo = Photos::PusherService.new(params, current_user).create
        render json: photo, status: :created
      end

      def update
        photo = Photos::PusherService.new(params, current_user).update
        render json: photo, status: :created
      end

      def destroy
        Photos::DestroyerService.call(params[:id])
        render json: { message: 'Photo deleted' }, status: :ok
      end
    end
  end
end
