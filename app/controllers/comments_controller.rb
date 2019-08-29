class CommentsController < ApplicationController
  before_action :set_article, only: [:create]
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!, :except => [:create]

  def create
    @comment = @article.comments.create(comments_param)
    redirect_to article_path(@article)
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      set_article
      @comment = @article.comments.find(params[:id])
    end

    def comments_param
      params.require(:comment).permit(:commenter, :body)
    end
end
