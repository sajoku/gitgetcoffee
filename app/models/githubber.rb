class Githubber
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  #include MotionModel::Validatable

  columns name: :string,
    id: :integer,
    avatar_url: :string,
    html_url: :string,
    followers_url: :string,
    following_url: :string

  #validates :name, :presence => true

end
