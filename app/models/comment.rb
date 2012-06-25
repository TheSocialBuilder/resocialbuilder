class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  field :author, :type => String
  field :content, :type => String
  
  # attr_accessible :text, :author
  
  belongs_to :commentable, polymorphic: true, autosave: true
  
end
