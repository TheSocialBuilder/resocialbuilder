class ListingsController < ApplicationController

  def index
    @listings = Listing.all
  end


  def mls
    
    select_fields = ['LIST_1','LIST_105','LIST_9','LIST_15','LIST_22','LIST_35','LIST_39','LIST_40','LIST_41', 'LIST_43','LIST_48','LIST_53','LIST_57','LIST_60','LIST_66','LIST_67','LIST_77','LIST_78','LIST_71','LIST_120','LIST_121','LIST_122','GF20060601190119598775000000','GF20060804131623427324000000','GF20060609021220658114000000','GF20060804131609269095000000','GF20060804124524581455000000','GF20060809131734372173000000','listing_office_name','LIST_106','LIST_5','LIST_31','LIST_33','LIST_34','LIST_36','LIST_37']
    
    
    rets_login_url = "http://retsgw.flexmls.com:80/rets2_0/Login";
    rets_username = "stg.rets.efowlke";
    rets_password = "magic-rrhine78";
    
    client = RETS::Client.login(:url => rets_login_url, :username => rets_username, :password => rets_password)
    

    client.search(:search_type => :Property, :class => 'A', :limit => 1, :select => select_fields) do |data|
      
      listing = Listing.find_or_initialize_by(listing: data['LIST_105'])      
      # listing = Listing.new
      
      listing.mls = 'stgeorge'
      listing.listing = data['LIST_105']
      listing.type = data['LIST_9']
      listing.status = data['LIST_15']
      listing.price = data['LIST_22']

      location = Location.new(:address_1 => "#{data['LIST_31']} #{data['LIST_33']} #{data['LIST_34']} #{data['LIST_36']} #{data['LIST_37']}", :address_2 => "#3", :city => data['LIST_39'], :state => data['LIST_40'], :zip => data['LIST_43'])
      
      listing.location = location
      
      listing.mls_area = data['LIST_41']
      listing.square_feet = data['LIST_48']
      listing.year = data['LIST_53']
      listing.acres = data['LIST_57']
      listing.short_sale = data['LIST_60']
      listing.beds = data['LIST_66']
      listing.baths = data['LIST_67']
      listing.sub_division = data['LIST_77']
      listing.description = data['LIST_78']
      listing.garage_type = data['LIST_71']
      listing.garage_capacity = data['LIST_120']
      listing.carport_capacity = data['LIST_121']
      listing.parking_capacity = data['LIST_122']
      listing.features = data['GF20060601190119598775000000']
      listing.pool = data['GF20060804131623427324000000']
      listing.utilities = data['GF20060609021220658114000000']
      listing.water = data['GF20060804131609269095000000']
      listing.landscape = data['GF20060804124524581455000000']
      listing.zoning = data['GF20060809131734372173000000']
      listing.brokered_by = data['listing_office_name']
      listing.office_id = data['LIST_106']
      listing.agent_id = data['LIST_5']
      
      
      id = data['LIST_105']
      
      # Loop through all the images and store them into a new array since this block is a bitch
      image_data = Array.new
      client.get_object(:resource => :Property, :type => :Photo, :location => true, :id => id+":*") do |object|
        image_data << object
      end

      
      image_data.each do |photo|
        # media = Media.new(:remote_media_url => photo['location'])
        listing.images.new(:remote_image_url => photo['location'])
      end
      
      
      listing.save
      
      
      
    end
    
    
    
  end
  
  


end
