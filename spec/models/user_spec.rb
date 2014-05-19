describe "User" do

  it "exists" do
    @user = User.new
    Object.const_defined?("User").should.be.true
  end

  it "has a name" do
    user =  User.new
    user.should.respond_to :name
  end

  it "has a repos url" do
    user = User.new
    user.should.respond_to :repos_url
  end


end

