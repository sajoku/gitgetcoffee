class MainController < UIViewController
  include MainView
  attr_accessor :user, :label

  def viewDidLoad
    super

    add_view_elements

    self.title = T7.t("GitGetCoffee")
    self.view.backgroundColor = UIColor.whiteColor

    true
  end

  def viewWillAppear(animated)
    if @user
      set_user
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


end
