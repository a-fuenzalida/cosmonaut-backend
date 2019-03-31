class PostsController < ApplicationController
  before_action :set_post, only: [:show, :tags]
  before_action :set_user_post, only: [:update, :destroy]

  # GET /posts
  def index
    @posts = Post.joins(:user).where(users: { private: false })

    if params[:user_id].present?
      @posts = @posts.find(params[:user_id]).posts
    elsif params[:tag_id].present?
      @posts = @posts.find(params[:tag_id]).posts
    end

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  def tags
    @tags = @post.tags
    render json: @tags
  end

  # POST /posts
  def create
    # Busca tags con formato "#tag" en la descripción del post
    # Se hace una iteración sobre los tags encontrados
    # Luego se crea el tag para relacionarlo con el post y si ya existe, genera solo la relación
    @post = current_user.posts
    tags = @post.description.scan(/(?:^|\s)#(\w+)/)
    tags.each do |tag|
      new_tag = Tag.where(label: tag).first_or_initialize
      new_tag.posts << @post
      new_tag.save
    end

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end 
  end

  # PATCH/PUT /posts/1
  def update
    if current_user.posts.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    # Elimina la relación entre el tag y el post eliminado
    PostTag.where(post_id: @post.id).destroy
    @post.destroy
  end

  private
    def set_post
      @post = Post.joins(:user).where(users: { private: false }).find(params[:id])
    end

    def set_user_post
      @post = current_user.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :description)
    end
end