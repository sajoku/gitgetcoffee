describe  'MainController' do
  tests MainController

  it 'sets the title' do
    controller.title.should.equal("GitGetCoffee")
  end

end
