class Api::V1::PagesController < Api::ApiController
  respond_to :json
  def index
    @pages = Page.all
    respond_with @pages
  end
  
  def show
    @page = Pages.find_by(:subdomain => current_subdomain)
    respond_with @page
  end
end
