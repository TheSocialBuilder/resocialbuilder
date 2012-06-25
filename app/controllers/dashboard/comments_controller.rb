class Dashboard::CommentsController < Dashboard::DashboardController  
  
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create

    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      redirect_to dashboard_blog_path(@commentable), notice: "Comment created."
    else
      render :new
    end
  end

private

  def load_commentable
    @commentable = current_account.blogs.find_by_slug(params[:blog_id])

  end

  # alternative option:
  # def load_commentable
  #   klass = [Blog].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end