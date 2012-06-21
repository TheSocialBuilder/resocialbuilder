class Dashboard::PagesController < Dashboard::DashboardController
  
  add_breadcrumb "Pages", :dashboard_pages_path
  
  
  
  def savesort
    neworder = JSON.parse(params[:set])
    # raise neworder.to_yaml
    prev_item = nil
    neworder.each do |item|
      # raise item.to_yaml
      db_item = current_account.pages.find(item['id'])
      
      if prev_item.nil?
        db_item.move_to_top
        db_item.parent_id = false
      else
        db_item.move_below(prev_item)
      end
      
      
      
      # raise dbitem.to_yaml
      # prev_item.nil? ? dbitem.move_to_top : dbitem.move_above(prev_item)
      sort_children(item, db_item) unless item['children'].nil?
      prev_item = db_item
      # dbitem.rearrange_children!
      db_item.save
    end
    
    render :nothing => true
  end
  
  def sort_children(element,current_db_item)
    prev_item = nil
    element['children'].each do |item|
      db_item = current_account.pages.find(item['id'])
      # raise childitem.to_yaml
      
      db_item.parent_id = current_db_item.id
      
      if prev_item.nil?
        db_item.move_children_to_parent
      else
        db_item.move_below(prev_item)
      end
      
      sort_children(item, db_item) unless item['children'].nil?
      prev_item = db_item
      db_item.save
    end
  end
  
  
  
  
  
  
  
  
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
    @build_tree_select = current_account.pages.traverse(:depth_first).map{|node| ["#{'--' * node.depth}- #{node.title}",node.id]}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end


  def edit
    add_breadcrumb "Updating Page", edit_dashboard_page_path
    @page = current_account.pages.find_by_slug(params[:id])
    
    @build_tree_select = current_account.pages.traverse(:depth_first).map{|node| ["#{'--' * node.depth}- #{node.title}",node.id]}
  end


  def create
    @page = current_account.pages.new(params[:page])

    respond_to do |format|
      if @page.save
        
        
        soul = Soulmate::Loader.new("page #{current_account.id}")
        soul.add("term" => @page.title, "id" => @page.id, "data" => {"url" => edit_dashboard_page_path(@page.slug), "subtitle" => @page.title})
        
        
        format.html { redirect_to dashboard_page_path(@page), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    # raise params[:page][:parent_id].to_yaml
    @page = current_account.pages.find_by_slug(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        
        soul = Soulmate::Loader.new("page #{current_account.id}")
        soul.add("term" => @page.title, "id" => @page.id, "data" => {"url" => edit_dashboard_page_path(@page.slug), "subtitle" => @page.title})
        
        
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
    
    soul = Soulmate::Loader.new("page #{current_account.id}")
    soul.remove("id" => @page.id)
    
    @page.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_pages_path }
      format.json { head :no_content }
    end
  end
end
