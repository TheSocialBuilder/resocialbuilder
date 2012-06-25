class Activity
  include Streama::Activity

  activity :new_blog do
    actor :realtor, :cache => [:name]
    object :blog, :cache => [:title]
  end

end