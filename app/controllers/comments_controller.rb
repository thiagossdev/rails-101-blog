class CommentsController < ApplicationController
  before_action :set_article, only: [:create]
  before_action :set_comment, only: [:destroy]
  http_basic_authenticate_with name: "tss", password: "secret", only: [:destroy]

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
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

    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
