class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if current_user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end

  private
    def set_user
      @user_id = User.where(id: params[:id])
      @user_nickname = User.where(nickname: params[:id])

      if @user_id.present?
        @user = @user_id
      elsif @user_nickname.present?
        @user = @user_nickname
      else
        @user = User.find(params[:id])
      end
    end

    def user_params
      params.require(:user).permit(:nickname, :email, :picture, :datebirth, :password, :password_confirmation, :private, :visible, :name, :information)
    end
end