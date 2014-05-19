class Guest < User
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

  def name
    "Moss"
  end

  def following_url
    "https://api.github.com/users/octocat/following{/other_user}"
  end

  def followers_url
    "https://api.github.com/users/octocat/followers"
  end

  def followers
    0
  end

  def avatar_image
    UIImage.imageNamed("Untitled.png")
  end
end

