module ApplicationHelper
  def styleguide_block(section, &block)
    raise ArgumentError, "Missing block" unless block_given?


    @section = @styleguide.section(section)
    content = capture(&block)
    render 'dev/shared/styleguide_block', :section => @section, :example_html => content
  end
  
  def cards_total
    current_account.cards.length
  end
  
  def transactions_total
    current_account.transactions.length
  end
  
  
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
  
  def page_type
    [
      ['General Page', 1],
      ['Facebook Page', 2],
      ['Home Page', 3],
      ['Contact Page', 4]
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
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end
  
  # Helper function to get the current_profile
  def current_profile
    @current_profile ||= Account.find_by(subdomain: current_subdomain) if current_subdomain
  end

  # Helper function to get the current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  

  
  
  # Make sure we have a valid account we are dealing with on the website side
  def authenticate_subdomain!
    redirect_to 'http://lvh.me:3000/', alert: "The subdomain is not linked to a valid account" if current_account.nil?

  end
  
  # Check and force to make sure the user is logged in
  def authenticate_account!
    redirect_to login_path, alert: "You must be logged in to access this page" if current_account.nil?
  end
  


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
        ['Alabama', 'Alabama'],
        ['Alaska', 'Alaska'],
        ['Arizona', 'Arizona'],
        ['Arkansas', 'Arkansas'],
        ['California', 'California'],
        ['Colorado', 'Colorado'],
        ['Connecticut', 'Connecticut'],
        ['Delaware', 'Delaware'],
        ['District of Columbia', 'District of Columbia'],
        ['Florida', 'Florida'],
        ['Georgia', 'Georgia'],
        ['Hawaii', 'Hawaii'],
        ['Idaho', 'Idaho'],
        ['Illinois', 'Illinois'],
        ['Indiana', 'Indiana'],
        ['Iowa', 'Iowa'],
        ['Kansas', 'Kansas'],
        ['Kentucky', 'Kentucky'],
        ['Louisiana', 'Louisiana'],
        ['Maine', 'Maine'],
        ['Maryland', 'Maryland'],
        ['Massachusetts', 'Massachusetts'],
        ['Michigan', 'Michigan'],
        ['Minnesota', 'Minnesota'],
        ['Mississippi', 'Mississippi'],
        ['Missouri', 'Missouri'],
        ['Montana', 'Montana'],
        ['Nebraska', 'Nebraska'],
        ['Nevada', 'Nevada'],
        ['New Hampshire', 'New Hampshire'],
        ['New Jersey', 'New Jersey'],
        ['New Mexico', 'ew Mexico'],
        ['New York', 'New York'],
        ['North Carolina', 'North Carolina'],
        ['North Dakota', 'North Dakota'],
        ['Ohio', 'Ohio'],
        ['Oklahoma', 'Oklahoma'],
        ['Oregon', 'Oregon'],
        ['Pennsylvania', 'Pennsylvania'],
        ['Puerto Rico', 'Puerto Rico'],
        ['Rhode Island', 'Rhode Island'],
        ['South Carolina', 'South Carolina'],
        ['South Dakota', 'South Dakota'],
        ['Tennessee', 'Tennessee'],
        ['Texas', 'Texas'],
        ['Utah', 'Utah'],
        ['Vermont', 'Vermont'],
        ['Virginia', 'Virginia'],
        ['Washington', 'Washington'],
        ['West Virginia', 'West Virginia'],
        ['Wisconsin', 'Wisconsin'],
        ['Wyoming', 'Wyoming']
      ]
  end
  
end