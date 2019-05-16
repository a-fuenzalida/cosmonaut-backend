class FollowingsController < ApplicationController
  before_action :set_following, only: [:show, :update, :destroy]

  # GET /followings
  def index
    if params[:user_id].present?
      @followings = Following.joins(:user).where(following_id: params[:user_id]).select("users.id, users.name, users.nickname, users.picture")
    else
      @followings = Following.all
    end

    render json: @followings
  end

  # GET /followings/1
  def show
    render json: @following
  end

  # POST /followings
  def create
    @following = Following.new(following_params)

    if @following.save
      render json: @following, status: :created, location: @following
    else
      render json: @following.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /followings/1
  def update
    if @following.update(following_params)
      render json: @following
    else
      render json: @following.errors, status: :unprocessable_entity
    end
  end

  # DELETE /followings/1
  def destroy
    @following.destroy
  end

  # Mostrar los seguidores del usuario
  def followers
    @followings = User.find(params[:user_id]).following.joins(:user).select("users.id, users.name, users.nickname, users.picture, followings.created_at as since")
    render json: @followings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def following_params
      params.require(:following).permit(:user_id, :user_id)
    end
end