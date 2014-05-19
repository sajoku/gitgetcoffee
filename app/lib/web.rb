module Web

  def self.create_client
    AFMotion::SessionClient.build_shared("https://api.github.com") do
      session_configuration :default
      header "Accept", "application/json"
      response_serializer :json
    end
  end

  def self.get_followers_for_user(user, &blk)
    followers = []
    AFMotion::SessionClient.shared.get(user.followers_url) do |result|
      if result.success?
        result.object.each do |follower_json|
          follower =  Githubber.new(follower_json)
          followers << follower
        end
        blk.call(followers)
      end
    end
  end

  def self.get_followings_for_user(user, &blk)
    following = []
    following_url = user.following_url.split("{").first
    AFMotion::SessionClient.shared.get(following_url) do |result|
      if result.success?
        result.object.each do |following_json|
          githubber =  Githubber.new(following_json)
          following << githubber
        end
        blk.call(following)
      end
    end
  end

end
