module Api
  module V1
    class PhotosController < ApplicationController
      before_action :authenticate_user!
      before_action :find_photo, only: %i[show destroy]

      def index
        photos = Photo.all

        render json: photos
      end

      def show
        render json: @photo
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
        @photo.destroy
      end

      private

      def find_photo
        @photo = Photo.find(params[:id])
      end
    end
  end
end
