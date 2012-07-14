class Dashboard::FacebookPostsController < Dashboard::DashboardController

  before_filter :setup_menu
  # before_filter :setup_fb_pages

  def setup_menu
    gon.menu_active_accordian = 0
    gon.menu_active_link = 'facebook_posts'
  end
  
  def setup_fb_pages
    @facebook_pages = current_account.facebook.get_connections("me", "accounts") if current_account.facebook
    
    # raise @facebook_pages.to_yaml
    
    if @facebook_pages
      @facebook_pages.each do |fb_page|
    
        if fb_page['category'] != 'Application'
          page_graph = Koala::Facebook::GraphAPI.new(fb_page['access_token'])
          page = page_graph.get_object("me")
          # raise page.to_yaml

          facebook_page = current_account.facebook_pages.new
      
          facebook_page.realtor_id = current_account.id.to_s
          facebook_page.name = fb_page['name']
          facebook_page.access_token = fb_page['access_token']
          facebook_page.category = fb_page['category']
          facebook_page.fb_page_id = fb_page['id']
          facebook_page.perms = fb_page['perms'] if fb_page['perms']
        
          facebook_page.picture = page['picture']
          facebook_page.link = page['link']
          facebook_page.likes = page['likes']
          facebook_page.is_published = page['is_published']
          facebook_page.website = page['website']
          facebook_page.has_added_app = page['has_added_app']
          facebook_page.username = page['username']
          facebook_page.founded = page['founded']
          facebook_page.description = page['description']
          facebook_page.about = page['about']
          facebook_page.release_date = page['release_date']
          facebook_page.can_post = page['can_post']
          facebook_page.talking_about_count = page['talking_about_count']
      
          facebook_page.save
        end
      
      end
    end

  end


  def index
    @facebook_posts = current_account.facebook_posts.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facebook_posts }
    end
  end


  def show
    @facebook_post = current_account.facebook_posts.find(params[:id])

    respond_to do |format|
      format.html { render "edit" }
      format.json { render json: @facebook_post }
    end
  end

  def new
    @facebook_post = current_account.facebook_posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facebook_post }
    end
  end


  def edit
    @facebook_post = current_account.facebook_posts.find(params[:id])
  end


  def create
    @facebook_post = current_account.facebook_posts.new(params[:facebook_post])

    # raise @facebook_post.to_yaml

    respond_to do |format|
      if @facebook_post.save
        
        # @facebook_page = current_account.facebook_pages.find(@facebook_post.facebook_page_id)
        
        # raise @facebook_page.to_yaml
        
        # @page_graph = Koala::Facebook::GraphAPI.new(@facebook_page.access_token)
        # @page_application = @page_graph.get_connections(@facebook_page.fb_page_id, 'accounts', @facebook_page.access_token)
        # raise @page_application.to_yaml
        # 
        # @page_graph.put_connections(@facebook_page.fb_page_id, 'feed', :message => 'This is posted as the page')
        # post = @page_graph.put_connections(@facebook_page.fb_page_id, 'feed', :message => 'Testing some new features!')
        #         raise post.to_yaml
        
        
        format.html { redirect_to dashboard_facebook_posts_path, notice: 'Facebook Post was successfully created.' }
        format.json { render json: @facebook_post, status: :created, location: @facebook_post }
      else
        format.html { render action: "new" }
        format.json { render json: @facebook_post.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @facebook_post = current_account.facebook_posts.find(params[:id])

    respond_to do |format|
      if @facebook_post.update_attributes(params[:facebook_post])
        
        format.html { redirect_to dashboard_facebook_posts_path, notice: 'Facebook Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facebook_post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @facebook_post = current_account.facebook_posts.find(params[:id])
    @facebook_post.destroy

    redirect_to dashboard_facebook_posts_path
  end
end
