class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :edit, :destroy]
  before_action :set_article_for_comment, only: [:create, :update]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :destroy]
  def new
    @comment = @article.comments.new
  end
  
  def create
    @comment = @article.comments.new(comment_params)
   if @comment.save
     flash[:notice] = "Comment was successfully created"
    redirect_to article_path(@article)
   else
    render 'new'
   end
  end
  
  def edit
  end

  def update
     if @comment.update(comment_params)
       flash[:success]="Comment has been successfully updated"
       redirect_to article_path(@article)
     else 
       render 'edit'
     end
  end

  def destroy
    @comment.destroy
    flash[:danger] = "Comment has been successfully deleted"
    redirect_to articles_path
  end
  
  
  
  private
  def comment_params
    params.require(:comment).permit(:comment, :article_id) 
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def set_article_for_comment
    @article = Article.find(params[:comment][:article_id])
  end
  
  def set_article
    @article = Article.find(params[:article_id])
  end
  
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own comment"
      redirect_to root_path
    end
  end

end