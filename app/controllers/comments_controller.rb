class CommentsController < ApplicationController
  before_action :define_content_header
  before_action :define_article
  before_action :set_comment, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  # GET /comments
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments.all
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = @article.comments.create(comment_params)
    if @comment.save
      render json: @comment, status: :created, location: @article
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    render json: @comment
    @comment.destroy
  end

  private
    def record_not_found(error)
      render :json => {:error => "/^not found$/gi"}.to_json, :status => 404
    end

    def define_content_header
      response.headers["Content-Type"] = "application/json"
    end

    def define_article
      @article = Article.find(params[:article_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit(:author, :comment)
  end

end
