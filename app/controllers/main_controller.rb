class MainController < UIViewController
  include MainView

  attr_accessor :user, :label, :followers, :following, :repos, :followers_not_following

  def viewDidLoad
    super

    add_view_elements

    self.title = T7.t("Github - Social")
    self.view.backgroundColor = UIColor.whiteColor

    add_followers_not_following_table

    true
  end

  def viewWillAppear(animated)
    @followers_not_following = []
    followers_not_following_table.reloadData

    if @user
      set_user
      get_followers
      get_following
    end
  end

  def add_user(sender)
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
    following_url = @user.following_url.split("{").first
    AFMotion::SessionClient.shared.get(following_url) do |result|
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
        @followers_not_following << follower
      end
    end
    followers_not_following_table.reloadData
  end

  def followers_not_following_table
    @followers_not_following_table ||= UITableView.alloc.initWithFrame([[0.0, 300.0], [320.0, 240.0]])
  end

  def add_followers_not_following_table
    followers_not_following_table.backgroundView = nil
    followers_not_following_table.backgroundColor = UIColor.turquoiseColor
    followers_not_following_table.dataSource = self
    followers_not_following_table.delegate = self
    self.view.addSubview(followers_not_following_table)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)

    unless cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.selectionStyle = UITableViewCellSelectionStyleNone
    end

    follower = @followers_not_following[indexPath.row]
    if follower
      cell.textLabel.text = follower.login.to_s
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @followers_not_following.count || 0
  end


end
