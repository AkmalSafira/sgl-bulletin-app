class CommentsController < ApplicationController
  def new
    @comment = Comment.new(article_id: params[:article_id])
  end
  
  def create
    @article = Article.find(params[:comment][:article_id])
    @comment = @article.comments.new(comment_params)
   if @comment.save
     flash[:notice] = "Comment was successfully created"
    redirect_to article_path(@article)
   else
    render 'new'
   end
  end
  
  
  
  private
  def comment_params
    params.require(:comment).permit(:content, :article_id) 
  end
end