class Stgeorge < ApplicationController

  before_filter :start

  def self.start
    @market = ::Mls::Market.find_by(:title => 'stgeorge')
    
    @client = RETS::Client.login(:url => @market.login_url, :username => @market.username, :password => @market.password)
  end
  

  def self.search_office
    raise @market.to_yaml
    @client.search(:search_type => :Office, :class => :Office, :limit => 1) do |data|
      save_office(data)
    end
      
  end
  
  
  def self.save_office(data)
    raise data.to_yaml

    office = @mls_market.offices.find_or_initialize_by(:internal_office_id => data['OFFICE_0'])

    office.internal_office_id = data['OFFICE_0']
    office.internal_office_nrds_id = data['OFFICE_1']
    office.name = data['OFFICE_2']
    office.phone = data['OFFICE_3']
    office.email = data['OFFICE_8']
    office.internal_office_short_id = data['OFFICE_15']
    office.last_updated = data['TIMESTAMP']
    office.active = data['STATUS']
    
    if data['OFFICE_10']
      office.location_attributes = {:address_1 => data['OFFICE_10'], :address_2 => data['OFFICE_11'], :city => data['OFFICE_12'], :state => data['OFFICE_13'], :zip => data['OFFICE_14']}
    end
  
    office.save

    
  end



end