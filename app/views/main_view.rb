module MainView

  def add_view_elements
    add_user_button.accessibilityLabel = "Add user"
    self.navigationItem.rightBarButtonItem = add_user_button

    create_username_label
    create_user_avatar
    create_followers_label
    create_non_followers_label
  end

  def add_user_button
    @add_user_button ||= UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd,target: self, action: 'add_user:')
  end

  def username_label
    @username_label ||= UILabel.alloc.initWithFrame(CGRectZero)
  end

  def user_avatar
    @user_avatar ||= UIImageView.alloc.initWithImage(user_avatar_image)
  end

  def followers_label
    @followers_label ||= UILabel.alloc.initWithFrame(CGRectZero)
  end

  def non_followers_label
    @non_followers_label ||= UILabel.alloc.initWithFrame(CGRectZero)
  end

  private

  def create_followers_label
    followers_label.color = UIColor.turquoiseColor
    followers_label.center = CGPointMake(95, 260)
    self.view.addSubview(followers_label)
  end

  def create_username_label
    username_label.color = UIColor.turquoiseColor
    username_label.center = CGPointMake(App.bounds.size.width / 2, 170)
    username_label.text = "Moss"
    username_label.sizeToFit
    self.view.addSubview(username_label)
  end

  def create_user_avatar
    user_avatar.frame = [[0, 0], [100.0, 100.0]]
    user_avatar.center = CGPointMake(App.bounds.size.width / 2, 120)
    user_avatar.clipsToBounds = true
    user_avatar.layer.setCornerRadius(50)

    self.view.addSubview(user_avatar)
  end

  def create_non_followers_label
    non_followers_label.color = UIColor.turquoiseColor
    non_followers_label.center = CGPointMake(50, 320)
    non_followers_label.numberOfLines = 0
    non_followers_label.lineBreakMode = NSLineBreakByWordWrapping
    self.view.addSubview(non_followers_label)
  end


  def user_avatar_image
    @user_avatar_image ||= UIImage.imageNamed("Untitled.png")
  end

end
