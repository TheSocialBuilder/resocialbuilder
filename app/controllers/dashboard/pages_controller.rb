class Dashboard::PagesController < Dashboard::DashboardController
  
  add_breadcrumb "Pages", :dashboard_pages_path
  def index
    @pages = current_account.pages.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end


  def show
    add_breadcrumb "Showing Page", dashboard_page_path
    @page = current_account.pages.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def new
    add_breadcrumb "Creating New Page", new_dashboard_page_path
    @page = current_account.pages.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end


  def edit
    add_breadcrumb "Updating Page", edit_dashboard_page_path
    @page = current_account.pages.find_by_slug(params[:id])
  end


  def create
    @page = current_account.pages.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to dashboard_page_path(@page), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @page = current_account.pages.find_by_slug(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to dashboard_page_path(@page), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @page = current_account.pages.find_by_slug(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_pages_path }
      format.json { head :no_content }
    end
  end
end
