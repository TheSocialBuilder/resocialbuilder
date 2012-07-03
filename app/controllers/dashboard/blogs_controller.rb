class Dashboard::BlogsController < Dashboard::DashboardController

  before_filter :setup_menu

  def setup_menu
    gon.menu_active_accordian = 'dashboard'
    gon.menu_active_link = 'blogs'
  end


  add_breadcrumb "Blogs", :dashboard_blogs_path
  def index
    @blogs = current_account.blogs.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end


  def show
    add_breadcrumb "Showing Blog", dashboard_blog_path
    @blog = current_account.blogs.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end
  
  def manage_comments
    add_breadcrumb "Manage Blog Comments", dashboard_blog_path
    @blog = current_account.blogs.find_by_slug(params[:id])
    
    @commentable = @blog
    @comments = @commentable.comments
    @comment = Comment.new
  

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  def new
    add_breadcrumb "Creating New Blog", new_dashboard_blog_path
    @blog = current_account.blogs.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end


  def edit
    add_breadcrumb "Updating Blog", edit_dashboard_blog_path
    @blog = current_account.blogs.find_by_slug(params[:id])
  end


  def create
    @blog = current_account.blogs.new(params[:blog])

    respond_to do |format|
      if @blog.save
        
        # Activity.create_indexes
        
        # current_account.publish_activity(:new_blog, :object => @blog)
        
        soul = Soulmate::Loader.new("blog #{current_account.id}")
        soul.add("term" => @blog.title, "id" => @blog.id, "data" => {"url" => edit_dashboard_blog_path(@blog.slug), "subtitle" => @blog.title})
        
        format.html { redirect_to dashboard_blog_path(@blog), notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @blog = current_account.blogs.find_by_slug(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        
        soul = Soulmate::Loader.new("blog #{current_account.id}")
        soul.add("term" => @blog.title, "id" => @blog.id, "data" => {"url" => edit_dashboard_blog_path(@blog.slug), "subtitle" => @blog.title})
        
        
        format.html { redirect_to dashboard_blog_path(@blog), notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @blog = current_account.blogs.find_by_slug(params[:id])
    
    soul = Soulmate::Loader.new("blog_#{current_account.id}")
    soul.remove("id" => @blog.id)
    
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_blogs_path }
      format.json { head :no_content }
    end
  end
end
