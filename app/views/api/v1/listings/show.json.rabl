object @listing

attributes :id, :short_sale, :listings, :location, :price, :beds, :baths, :description, :type, :features, :default_image




# node :images do |img|
#   attributes :primary => img.images[1].image_object_id
# end
# node :targets do |t|
#   partial("api/v1/targets/show", :object => find_target_by_id(t.target_ids))
# end