module Api
  module V1
    class PhotosController < ApplicationController
      before_action :set_photo, only: %i[show update destroy]
      before_action :authorized

      # GET /photos
      def index
        @photos = Photo.where(user: @user.id)

        render json: @photos
      end

      # GET /photos/1
      def show
        image = rails_blob_path @photo.image
        # render json: {photo: @photo, image: image}
        render json: @photo
      end

      # POST /photos
      def create
        @photo = Photo.new(photo_params)
        @photo.user = @user

        if @photo.save
          render json: @photo, status: :created, location: api_v1_photos_path(@photo)
        else
          render json: @photo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /photos/1
      def update
        if @photo.update(photo_params)
          # image_url = rails_blob_path(@photo.image)
          # byebug
          render json: @photo
        else

          render json: @photo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /photos/1
      def destroy
        @photo.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_photo
        @photo = Photo.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def photo_params
        params.permit(:name, :image, :user_id)
      end
    end
  end
end