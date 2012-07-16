class ListingsController < ApplicationController

  def index
    @listings = Listing.all
  end
  
  def connect_client
    RETS::Client.login(:url => @market.login_url, :username => @market.username, :password => @market.password)
  end
  
  
  def nnrmls
    
    @market = Mls::Market.find_by(:title => 'nnrmls')
    @client = connect_client
  
    
    
    listings_query = "(L_UpdateDate=2011-05-01T00:00:00+)"
    
    # search_agent
    search_office
  
    raise "Saved all Agent Data"
  end
  

  
  
  
  def stgeorge
    
    @market = Market.find_by(:title => 'stgeorge')
    @client = connect_client
    
    # search_agent
    # search_office
    mls
    
    raise "Saved all Agent Data"
  end
  
  def search_office
    
    if @market.title == 'stgeorge'
      
      # data_array = Array.new
      @client.search(:search_type => :Office, :class => :Office) do |data|
        # data_array << data
        save_office(data)
      end
      # raise data_array.to_yaml
      
    end
    
    
    if @market.title == 'nnrmls'
      
      office_query = "(O_UpdateDate=2011-06-01T00:00:00+)"
      
      data_array = Array.new
      @client.search(:search_type => :Office, :class => :Office, :limit => 2500, :query => office_query) do |data|
        data_array << data
        save_office(data)
      end
      raise data_array.to_yaml
    end
    
  end
  
  
  def save_office(data)
    
    if @market.title == 'stgeorge'
      office = @market.offices.find_or_initialize_by(:internal_office_id => data['OFFICE_0'])

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
      # raise office.to_yaml
    end
    
    if @market.title == 'nnrmls'
      office = @market.offices.find_or_create_by(:internal_office_id => data['O_OfficeID'])

      office.internal_office_id = data['O_OfficeID']
      # office.internal_office_nrds_id = data['OFFICE_1']
      office.name = data['O_OrganizationName']
      office.email = data['O_EMail']
      office.internal_office_short_id = data['O_ShortName']
      office.last_updated = data['O_UpdateDate']
      
      office.active = true
      
      if data['O_PhoneNumber1'] != ''
        office.phone = "#{data['O_PhoneNumber1Area']}-#{data['O_PhoneNumber1']}"
      else
        office.phone = ""
      end
      
      if data['O_OrgAddressStreet']
        office.location_attributes = {:address_1 => data['O_OrgAddressStreet'], :address_2 => data['O_OrgAddress2'], :city => data['O_OrgCity'], :state => data['O_OrgState'], :zip => data['O_OrgZip']}
      end
      
      office.save
    end
    
  end
  
  
  def search_agent
    
    if @market.title == 'stgeorge'
      
      @client.search(:search_type => :Agent, :class => :Agent) do |data|
        save_agent(data)
      end
      
    end
    
    
    if @market.title == 'nnrmls'
      
      agents_query = "(U_UpdateDate=2012-06-01T00:00:00+)"
      
      @client.search(:search_type => :Agent, :class => :Agent, :query => agents_query) do |data|
        save_agent(data)
      end
      
    end
    
  end
  
  
  def save_agent(data)
    
    if @market.title == 'stgeorge'
      agent = @market.agents.find_or_create_by(:internal_agent_id => data['MEMBER_0'])

      agent.internal_agent_id = data['MEMBER_0']
      agent.internal_agent_nrds_id = data['MEMBER_2']
      agent.internal_office_id = data['MEMBER_1']
      agent.first_name = data['MEMBER_3'].titlecase
      agent.last_name = data['MEMBER_4'].titlecase
      agent.phone = data['MEMBER_21']
      agent.email = data['MEMBER_10']
      agent.internal_agent_short_id = data['MEMBER_17']
      agent.internal_office_short_id = data['OFFICESHORT']
      agent.last_updated = data['TIMESTAMP']
      agent.active = data['STATUS']
    
      agent.save

    end
    
    if @market.title == 'nnrmls'
      agent = @market.agents.find_or_create_by(:internal_agent_id => data['U_AgentID'])


      agent.internal_agent_id = data['U_AgentID']
      agent.internal_agent_nrds_id = data['U_UserCode']
      agent.internal_office_id = data['U_HiddenOrgID']
      agent.first_name = data['U_UserFirstName'].titlecase
      agent.last_name = data['U_UserLastName'].titlecase
      agent.email = data['U_Email']
      agent.internal_agent_short_id = data['U_UserCode']
      agent.internal_office_short_id = data['AO_ShortName']
      agent.last_updated = data['U_UpdateDate']
      
      agent.active = true if data['U_user_is_active'] == 'Yes'
      
      if data['U_PhoneNumber1'] != ''
        agent.phone = "#{data['U_PhoneNumber1Area']}-#{data['U_PhoneNumber1']}"
      else
        agent.phone = ""
      end
      
      agent.save
    end
    
  end


  def mls
    
    # mls = Mls.new
    # mls = Mls.find('4fd0283f9a6f23af26000096')
    
    
    # mls.login_url = "http://retsgw.flexmls.com:80/rets2_0/Login"
    # 
    # 
    search_fields = ['LIST_1','LIST_105','LIST_9','LIST_15','LIST_22','LIST_35','LIST_39','LIST_40','LIST_41', 'LIST_43','LIST_48','LIST_53','LIST_57','LIST_60','LIST_66','LIST_67','LIST_77','LIST_78','LIST_71','LIST_120','LIST_121','GF20060601190119598775000000','GF20060804131623427324000000','GF20060609021220658114000000','GF20060804131609269095000000','GF20060804124524581455000000','GF20060809131734372173000000','listing_office_name','LIST_106','LIST_5','LIST_31','LIST_33','LIST_34','LIST_36','LIST_37', 'LIST_87']
    # 
    # 
    # mls.login_url = "http://retsgw.flexmls.com:80/rets2_0/Login";
    # mls.username = "stg.rets.efowlke";
    # mls.password = "magic-rrhine78";
    
    
    
    # @client = RETS::Client.login(:url => mls.login_url, :username => mls.username, :password => mls.password)
    
    
    # # meta_data = get_meta('METADATA-SYSTEM', '*')
    # # meta_data = get_meta('METADATA-TABLE', 'ActiveAgent:*')
    # meta_data = get_meta('METADATA-TABLE', 'Property:*')
    # 
    # # raise meta_data.to_yaml
    # 
    # 
    # field_meta_data = buildFieldData(meta_data)
    # 
    # raise field_meta_data.to_yaml
    # 
    # 
    # 
    # 
    # meta_data = Array.new
    # client.get_metadata(:type => 'METADATA-LOOKUP_TYPE', :id => 'Property:*') do |type, attrs, metadata|
    #   # raise metadata.to_json
    #   
    #   meta = Array.new
    #   
    #   metadata.each do |meta_info|
    #     meta << meta_info['LongValue']
    #   end
    # 
    #   meta_data << [:type => type, :resource => attrs['Resource'], :resource_id => attrs['Lookup'], :options => meta]
    # end
    # raise meta_data.to_yaml
    # mls.meta_data = meta_data
    # mls.save
    # raise
    # 
    # 
    # raise meta_data.to_yaml
    # , :select => select_fields
    # , :limit => 2
    @client.search(:search_type => :Property, :class => 'A', :select => search_fields, :limit => 50) do |data|




      listing = @market.listings.find_or_initialize_by(listing: data['LIST_105'])      

      listing.listing = data['LIST_105']
      listing.listing_timestamp = data['LIST_87']
      listing.type = data['LIST_9']
      listing.status = data['LIST_15']
      listing.price = data['LIST_22']
      listing.square_feet = data['LIST_48']
      listing.year = data['LIST_53']
      listing.acres = data['LIST_57']
      listing.short_sale = data['LIST_60']
      listing.beds = data['LIST_66']
      listing.baths = data['LIST_67']
      listing.sub_division = data['LIST_77'].titlecase
      listing.description = data['LIST_78']
      listing.garage_type = data['LIST_71']
      listing.garage_capacity = data['LIST_120']
      listing.carport_capacity = data['LIST_121']
      listing.features = data['GF20060601190119598775000000']
      listing.pool = data['GF20060804131623427324000000']
      listing.utilities = data['GF20060609021220658114000000']
      listing.water = data['GF20060804131609269095000000']
      listing.landscape = data['GF20060804124524581455000000']
      listing.zoning = data['GF20060809131734372173000000']
      listing.brokered_by = data['listing_office_name'].titlecase

      # Geocode the location
      listing.location_attributes = {:address_1 => "#{data['LIST_31']} #{data['LIST_33']} #{data['LIST_34']} #{data['LIST_36']} #{data['LIST_37']}", :address_2 => data['LIST_35'], :city => data['LIST_39'], :state => data['LIST_40'], :zip => data['LIST_43']}
      
      # Find the agent from the db
      agent = Agent.find_by(:internal_agent_id => data['LIST_5']) if data['LIST_5']
      listing.agent_id = agent.id.to_s unless agent.nil?
      
      # Find the office from the db
      office = Office.find_by(:internal_office_id => data['LIST_106']) if data['LIST_106']
      listing.office_id = office.id.to_s unless office.nil?
      
      
      
      

    
    
      
      # Resque.enqueue(ListingImages, listing.id.to_s)
      
      # raise listing.to_json
      
      id = data['LIST_105']
      
      # Loop through all the images and store them into a new array since this block is a bitch
      image_data = Array.new
      # @client.get_object(:resource => :Property, :type => :Photo, :location => true, :id => id+":1:2:3:4:5:6:7:8:9:10") do |object|
      @client.get_object(:resource => :Property, :type => :Photo, :location => true, :id => id+":1:2:3:4:5") do |object|
        image_data << object if object
      end
      
      
      image_data.each do |photo|
        listing.images.new(:remote_image_url => photo['location'], :location => photo['location'], :image_content_id => photo['content-id'], :image_object_id => photo['object-id'], :description => photo['content-description'], :preferred => photo['preferred'])
      end
      
      
      listing.save
      
      
      soul = Soulmate::Loader.new("listings #{@market.id}")
      soul.add("term" => "#{listing.listing} - #{listing.location.address_formatted}", "id" => listing.id, "data" => {"url" => dashboard_listing_path(listing), "subtitle" => "#{listing.listing} - #{listing.location.address_formatted}"})
      
      
      
    end
    
    
    
  end
  
  def get_meta(type, id)
    meta_data = Array.new
    @client.get_metadata(:type => type, :id => id) do |type, attrs, metadata|
      

      meta_data << ['type' => type, 'attributes' => attrs, 'meta_data' => metadata]
    end
    meta_data
  end

  def buildFieldData(meta_data)
    # raise meta_data.to_yaml
    meta_array = Array.new
        
    meta_data.first.each do |data|
      
      data['meta_data'].each do |data_2|
        
        meta_array << data_2['SystemName']
      end
      
      
    end
    raise meta_array.to_yaml
    meta_array
    
  end
  
  def array_from_hash(h)
    return h unless h.is_a? Hash

    all_numbers = h.keys.all? { |k| k.to_i.to_s == k }
    if all_numbers
        h.keys.sort_by{ |k| k.to_i }.map{ |i| array_from_hash(h[i]) }
    else
        h.each do |k, v|
                h[k] = array_from_hash(v)
        end
    end
end
  
end
