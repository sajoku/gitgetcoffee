describe  "MainController" do
  tests MainController

  it "sets the title" do
    controller.title.should.equal("GitGetCoffee")
  end

  # it "loads the new user form controller" do
  #   tap "Add user"
  #   view("Search GitHub").should.not == nil
  # end

end
