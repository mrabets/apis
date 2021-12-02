class  Api::V1::LikesController < ApplicationController
  before_action :find_photo
  before_action :authorized 
  before_action :find_like
  
  def destroy
    if !(already_liked?) || @like.nil?
      render json: { message: 'Photo already unlike' } , status: :unprocessable_entity
    else
      @like.liked = false
      @like.save
      render json: { message: 'Successfully unlike' } , status: 200
    end
  end

  def create  
    if @like.present?
      if already_liked?
        render json: { message: 'Photo already like' } , status: :unprocessable_entity
      else
        @like.liked = true
        @like.save

        render json: @like , status: :created, location: api_v1_photos_path(@photo)
      end
    else
      @like = @photo.likes.create(user_id: @user.id, liked: true)
      render json: @like , status: :created, location: api_v1_photos_path(@photo)
    end
  end

  private

  def already_liked?
    @like.liked?
  end

  def find_photo
    @photo = Photo.find(params[:photo_id])
  end

  def find_like
    @like = @photo.likes.find_by(
      user_id: @user.id, 
      photo_id: params[:photo_id]
    )
 end
end
