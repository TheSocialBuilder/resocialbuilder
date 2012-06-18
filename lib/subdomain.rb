class Subdomain
  def self.matches?(request)  
    request.subdomain.present? && request.subdomain != 'www' && request.subdomain != 'soulmate'
  end
end