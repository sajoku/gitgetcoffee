class MainController < UIViewController
  include MainView
  attr_accessor :user, :label, :followers, :following

  def viewDidLoad
    super

    add_view_elements

    self.title = T7.t("Github - Social")
    self.view.backgroundColor = UIColor.whiteColor

    true
  end

  def viewWillAppear(animated)
    if @user
      set_user
      get_followers
      get_following
    end
  end

  def add_user(sender)
    puts 'pressed ADD_USER'

    controller = NewUserFormController.alloc.init
    controller.parent = self
    self.navigationController.pushViewController(controller, animated: true)
  end

  def set_user
    username_label.text = @user.name
    username_label.sizeToFit

    follower_message = T7.t("Has #followers# followers")
    followers_label.text = T7.e(follower_message, followers: @user.followers.to_s)
    followers_label.sizeToFit

    avatar_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(@user.avatar_url))
    image = UIImage.alloc.initWithData(avatar_data)
    user_avatar.image = image
  end

  def get_followers
    puts 'GETTING FOLLOWERS'
    puts @user.followers_url
    AFMotion::SessionClient.shared.get(@user.followers_url) do |result|
      if result.success?
        @followers = []

        result.object.each do |follower_json|
          follower =  Githubber.new(follower_json)
          @followers << follower
        end
      end
    end
  end

  def get_following
    puts 'GETTING FOLLOWING'
    puts @user.following_url
    following_url = @user.following_url.split("{").first
    AFMotion::SessionClient.shared.get(following_url) do |result|
      puts result.to_s
      if result.success?
        @following = []

        result.object.each do |following_json|
          following =  Githubber.new(following_json)
          @following << following
        end

        sift_followers_from_following
      end
    end
  end

  def sift_followers_from_following
    follower_ids = @followers.map(&:id)
    following_ids = @following.map(&:id)

    following_ids.delete_if{|id| follower_ids.include?(id) }
    following_names = []
    @following.each do |follower|
      if following_ids.include?(follower.id)
        following_names << follower.login
      end
      non_followers_label.text = following_names.join(" ")
      non_followers_label.sizeToFit
    end
  end

end
