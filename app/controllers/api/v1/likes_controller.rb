class  Api::V1::LikesController < ApplicationController
  before_action :find_photo, :authorized , :find_like

  def destroy
    if !(Likes::AlreadyLikedService.new(photo: @photo, user: @user).call) || @like.nil?
      render json: { message: 'Photo already unlike' } , status: :unprocessable_entity
    else
      Likes::DestroyerService.new(like: @like, photo: @photo, user: @user).destroy
      render json: { message: 'Successfully unlike' } , status: 200
    end
  end

  def create  
    if @like.present?
      if Likes::AlreadyLikedService.new(photo: @photo, user: @user).call
        render json: { message: 'Photo already like' } , status: :unprocessable_entity
      else
        Likes::UpdaterService.new(like: @like).update
        render json: @like , status: :created, location: api_v1_photos_path(@photo)
      end
    else
      Likes::CreatorService.new(photo: @photo, user: @user).create
      render json: @like , status: :created, location: api_v1_photos_path(@photo)
    end
  end

  private

  def find_photo
    @photo = Photo.find(params[:photo_id])
  end

  def find_like
    @like = Likes::FinderService.new(photo: @photo, user: @user).call
  end
end
