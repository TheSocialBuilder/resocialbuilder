object @account

attributes :id, :first_name, :last_name, :agent_id, :address, :city, :county, :state, :postal_code, :coordinates, :company, :email, :facebook_page_id, :featured_listings, :mls_id, :office_id, :office_or_agent, :phone, :search_max, :search_min, :site_title, :social_facebook, :social_twitter, :subdomain, :time_zone, :template

node :logo do |account|
  attributes :original => account.logo.url, :medium => account.logo.url(:medium), :thumbnail => account.logo.url(:thumb)
end
node :avatar do |account|
  attributes :original => account.avatar.url, :medium => account.avatar.url(:medium), :thumbnail => account.avatar.url(:thumb)
end

child(:pages) { attributes :name, :slug, :content }
# node :pages do |page|
#   attributes :content => page.pages.content
# end