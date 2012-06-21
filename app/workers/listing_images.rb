class ListingImages < ApplicationController
  @queue = :listing_images_queue
  def self.perform(listing_id, account_id)
    
    
    
    market = Market.find_by(:title => 'stgeorge')
    client = RETS::Client.login(:url => market.login_url, :username => market.username, :password => market.password)
    
    listing = Listing.find(listing_id)
    
    
    
    # Loop through all the images and store them into a new array since this block is a bitch
    image_data = Array.new
    client.get_object(:resource => :Property, :type => :Photo, :location => true, :id => listing.listing+":1:2:3:4:5:6:7:8:9:10") do |object|
      image_data << object if object
    end
    
    
    image_data.each do |photo|
      listing.images.new(:remote_image_url => photo['location'], :location => photo['location'], :image_content_id => photo['content-id'], :image_object_id => photo['object-id'], :description => photo['content-description'], :preferred => photo['preferred'])
    end
      
      
      listing.save
  end
end