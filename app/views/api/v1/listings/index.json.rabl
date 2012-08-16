collection @listings
cache @listings

# code(:total_entries) { @listings.total_entries }
# code(:current_page) { @listings.current_page }
# code(:total_pages) { @listings.total_pages }
# code(:per_page) { @listings.per_page }



extends "api/v1/listings/show"

# collection

node :pagination do |paginate|
  attributes :total_entries => @listings.total_entries, :current_page => @listings.current_page, :total_pages => @listings.total_pages, :per_page => @listings.per_page
end