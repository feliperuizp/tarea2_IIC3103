class CommentsController < ApplicationController
  before_action :define_content_header
  before_action :set_comment, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  # GET /comments
  def index
    @comments = Comment.all
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @article = Article.find(params[:article_id])
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
      head error
    end

    def define_content_header
      response.headers["Content-Type"] = "application/json"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:author, :cbody)
  end

end
