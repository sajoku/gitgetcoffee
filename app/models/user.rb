class User
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  #include MotionModel::Validatable

  columns name: :string,
    id: :integer,
    avatar_url: :string,
    html_url: :string,
    followers_url: :string,
    followers: :integer,
    following_url: :string,
    repos_url: :string

  #validates :name, :presence => true

  def avatar_image
    avatar_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(avatar_url))
    image = UIImage.alloc.initWithData(avatar_data)
  end

end
