object @listing


attributes :id, :short_sale, :listings, :location, :price, :beds, :baths, :description, :type, :features, :default_image

# node(:total_pages) {|listing| @paginate.total_count }



# object false

# node :total_pages do |paginate|
#   attributes :paginate => @listing.total_count
# end

# :total_entries, :current_page, :total_pages, :per_page

# node :paginate do |paginate|
#   attributes :paginate => paginate
# end


# node :targets do |t|
#   partial("api/v1/targets/show", :object => find_target_by_id(t.target_ids))
# end