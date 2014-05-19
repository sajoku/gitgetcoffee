describe  "MainController" do
  tests MainController

  it "sets the title" do
    controller.title.should.equal("Github - Experiment")
  end

  #it "loads the new user form controller" do
  #  tap "Add user"
  #  view("Search GitHub").should.not == nil
  #end

  it "loads the repos" do
    user = User.new(repos_url: "https://api.github.com/users/sajoku/repos" )
    controller.user = user
    controller.get_repos

    controller.repos.nil?.should == false
  end

end
