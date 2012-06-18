class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :mls_markets_supported, :default_office_or_agent, :default_prices, :current_account, :authenticate_account!, :current_user, :us_states, :page_assigned, :current_domain, :current_subdomain, :authenticate_subdomain!
  
  
  # Helper function to show and set just the domain name
  def current_domain
    @current_domain ||= request.domain if request.domain
  end
  
  # Helper function to show and set just the subdomain
  def current_subdomain
    @current_subdomain ||= request.subdomain if request.subdomain
  end

  
  
  def mls_markets_supported
    # [['Washington County, Utah', 'stgeorge'], ['Wasatch Front MLS', 'wfmls'], ['Northern Nevada Regional MLS', 'nnr']]
    [['Washington County, Utah', 'stgeorge'], ['Northern Nevada Regional MLS', 'nnr']]
  end
  
  # Hash used for the settings form
  def default_office_or_agent
    [['Agent ID - Use my listings for my pages', 'agent'], ['Company ID - Use my company listings for my pages', 'company']]
  end
  
  def page_assigned
    [
      ['General Page', 1],
      ['Facebook Page', 2],
      ['Website Home Page', 3]
    ]
  end
  
  def default_prices
    [
      ['$25,000', 25000],
      ['$50,000', 50000],
      ['$75,000', 75000],
      ['$100,000', 100000],
      ['$150,000', 150000],
      ['$200,000', 200000],
      ['$250,000', 250000],
      ['$300,000', 300000],
      ['$350,000', 350000],
      ['$400,000', 400000],
      ['$450,000', 450000],
      ['$500,000', 500000],
      ['$600,000', 600000],
      ['$700,000', 700000],
      ['$800,000', 800000],
      ['$900,000', 900000],
      ['$1,000,000', 1000000],
      ['$1,500,000', 1500000],
      ['$2,000,000', 2000000],
      ['$2,500,000', 2500000],
      ['$5,000,000', 5000000],
      ['$10,000,000', 10000000],
      ['$20,000,000', 20000000]
    ]
  end
  
  
  
  
  # Helper function to get the current_account
  def current_account
    session[:account_id] = '4fd26c77b48f662f60000001'
    begin
      if session[:account_id]
        @current_account ||= Account.find(session[:account_id]) 
        # session[:account_id]
      elsif current_subdomain
        @current_account ||= Account.find_by(:subdomain => current_subdomain)
      end
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end


  # Helper function to get the current_account
  def current_user
    begin
      @current_account ||= current_account if current_account
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end
  
  
  # Make sure we have a valid account we are dealing with on the website side
  def authenticate_subdomain!
    redirect_to 'http://lvh.me:3000/', alert: "The subdomain is not linked to a valid account" if current_account.nil?

  end
  
  # Check and force to make sure the user is logged in
  def authenticate_account!
    redirect_to login_path, alert: "You must be logged in to access this page" if current_account.nil?
  end
  
  protected

    def ckeditor_filebrowser_scope(options = {})
      super({ :assetable_id => current_account.id, :assetable_type => 'Account' }.merge(options))
    end
    
    # Set current_user as assetable
    def ckeditor_before_create_asset(asset)
      asset.assetable = current_account
      return true
    end
    
    def ckeditor_authenticate
      redirect_to '/', alert: "You must be logged in to access this page" if current_account.nil?
    end
    
    def us_states
      [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
      ]
  end
  
end
