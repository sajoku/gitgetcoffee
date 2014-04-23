describe "Githubber" do

  it "exists" do
    @githubber = Githubber.new
    Object.const_defined?("Githubber").should.be.true
  end

  it "has a name" do
    githubber =  Githubber.new
    githubber.should.respond_to :name
  end

end
