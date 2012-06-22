class Dashboard::DashboardController < ApplicationController
  layout "dashboard"

  before_filter :authenticate_account!
  # before_filter :set_timezone
  before_filter :set_facebook
  before_filter :setup_system
  before_filter :setup_menu
  
  respond_to :html, :json, :js
  
  add_breadcrumb "Dashboard", :dashboard_path
  
  def setup_menu
    
    gon.menu_active_accordian = 'dashboard'
    gon.menu_active_link = 'dashboard'
  end
  
  def set_facebook

    @facebook_pic ||= current_realtor.facebook.get_picture("me", {:type => "square"})
  end
  
  def setup_system
    gon.search_fields = ['user', 'listings 4fd6395e9a6f23070e00003b', "page #{current_account.id}", "blog #{current_account.id}"]
  end
  
  def index
    gon.menu_active_link = 'dashboard'
    # @listings = Listing.all.cache
  end
  
  def install_facebook(page_id)

    # Id of the RESB Application
    app_id = '208065319210030'
    
    @page_token = @facebook.get_page_access_token(page_id.to_s)
    
    @page_graph = Koala::Facebook::GraphAPI.new(@page_token['access_token'])
    
    @page_application = @page_graph.get_connections(page_id, 'tabs/'+app_id)
    
    # Check to see if the application is not installed
  
    @install_application_response = @page_graph.put_connections(page_id, 'tabs', :app_id => app_id)


    
  end
  
  
  def uninstall_facebook(page_id)

    # Id of the RESB Application
    app_id = '208065319210030'
    
    @page_token = @facebook.get_page_access_token(page_id.to_s)
    
    @page_graph = Koala::Facebook::GraphAPI.new(@page_token['access_token'])
    
    @page_application = @page_graph.get_connections(page_id, 'tabs/'+app_id.to_s).first
    # raise @page_application['id']
    # Check to see if the application is not installed
    if @page_application
      @uninstall_application_response = @page_graph.delete_object(@page_application['id'].to_s)
    end
    # raise @uninstall_application_response.to_yaml

    
  end
  
  def settings
    add_breadcrumb "Settings", dashboard_settings_path
    
    if params[:account]
      
      current_facebook_page_id = current_account.facebook_page_id if @facebook
      
      respond_to do |format|
        if current_account.update_attributes(params[:account])
          
          
          if current_facebook_page_id != params[:account][:facebook_page_id] && @facebook
            install_facebook(params[:account][:facebook_page_id])
            uninstall_facebook(current_facebook_page_id)
          end
          
          format.html { redirect_to dashboard_settings_path, notice: 'Settings was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "settings" }
          format.json { render json: dashboard_settings_path.errors, status: :unprocessable_entity }
        end
      end
    else
      @facebook_pages = @facebook.get_connections("me", "accounts") if @facebook
    end
  end
  
  def support

  end

  private
  
    # Set the users current timezone
    def set_timezone
      Time.zone = current_account.time_zone if current_account.time_zone
    end

end