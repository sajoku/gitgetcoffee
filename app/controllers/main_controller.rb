class MainController < UIViewController
  include MainView
  include MainControllerTableViewDelegate

  attr_accessor :user, :label, :followers, :following, :repos

  def viewDidLoad
    super
    self.title = T7.t("Github - Experiment")
    self.view.backgroundColor = UIColor.whiteColor

    add_view_elements
    add_followers_table_user
    add_following_table_user
    add_followers_table_button

    following_table_user.hidden = true

    true
  end

  def viewWillAppear(animated)
    @followers = []
    @following = []
    followers_table_user.reloadData
    following_table_user.reloadData

    if user
      set_user
      get_followers
      get_following
    end
  end

  def user
    @user || Guest.new
  end

  def add_user(sender)
    controller = NewUserFormController.alloc.init
    controller.parent = self
    self.navigationController.pushViewController(controller, animated: true)
  end

  def set_user
    username_label.text = user.name
    username_label.sizeToFit

    follower_message = T7.t("Has #followers# followers")
    followers_label.text = T7.e(follower_message, followers: user.followers.to_s)
    followers_label.sizeToFit

    set_user_avatar
  end

  def set_user_avatar
    user_avatar.image = user.avatar_image
  end

  def get_followers
    Web.get_followers_for_user(user) do |followers|
      @followers = followers
      followers_table_user.reloadData
      followers_table_user.stopRefreshAnimation
    end
  end

  def get_following
    Web.get_followings_for_user(user) do |following|
      @following = following
      following_table_user.reloadData
      following_table_user.stopRefreshAnimation
    end
  end

  def following_table_user
    @following_table_user ||= UITableView.alloc.initWithFrame([[0.0, 300.0], [320.0, 240.0]])
  end

  def add_following_table_user
    following_table_user.backgroundView = nil
    following_table_user.backgroundColor = UIColor.turquoiseColor
    following_table_user.dataSource = self
    following_table_user.delegate = self

    following_table_user.addPullToRefreshActionHandler(Proc.new{update_followers_table_user},
                                                                ProgressImagesGifName: "spinner_dropbox@2x.gif",
                                                                LoadingImagesGifName: "run@2x.gif",
                                                                ProgressScrollThreshold: 60,
                                                                LoadingImageFrameRate: 30)

    self.view.addSubview(following_table_user)
  end

  def followers_table_user
    @followers_table_user ||= UITableView.alloc.initWithFrame([[0.0, 300.0], [320.0, 240.0]])
  end

  def add_followers_table_user
    followers_table_user.backgroundView = nil
    followers_table_user.backgroundColor = UIColor.turquoiseColor
    followers_table_user.dataSource = self
    followers_table_user.delegate = self

    followers_table_user.addPullToRefreshActionHandler(Proc.new{update_followers_table_user},
                                                                ProgressImagesGifName: "spinner_dropbox@2x.gif",
                                                                LoadingImagesGifName: "run@2x.gif",
                                                                ProgressScrollThreshold: 60,
                                                                LoadingImageFrameRate: 30)

    self.view.addSubview(followers_table_user)
  end

  def update_followers_table_user
    get_followers
    get_following

    if @followers.count == 0
      followers_table_user.stopRefreshAnimation
    end
  end

  def add_followers_table_button
    button = FUIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = [[10.0, 250.0], [100.0, 45.0]]
    button.buttonColor = UIColor.turquoiseColor
    button.shadowColor = UIColor.greenSeaColor
    button.shadowHeight = 3.0
    button.cornerRadius = 6.0
    button.titleLabel.font = UIFont.boldFlatFontOfSize(16)
    button.setTitleColor(UIColor.cloudsColor, forState: UIControlStateNormal)
    button.setTitleColor(UIColor.cloudsColor, forState: UIControlStateHighlighted)
    button.setTitle("followers", forState: UIControlStateNormal)

    button.addTarget(self, action: "toggle_followers:", forControlEvents:  UIControlEventTouchUpInside)

    self.view.addSubview(button)
  end

  def toggle_followers(sender)
    following_table_user.hidden = !following_table_user.hidden?
    followers_table_user.hidden = !followers_table_user.hidden?
  end

end
