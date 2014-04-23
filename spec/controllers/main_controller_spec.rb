describe  'MainController' do
  tests MainController

  it 'sets the title' do
    controller.title.should.equal("GitGetCoffee")
  end

  it 'adds a user' do
    tap controller.navigationItem.rightBarButtonItem

    view('Add a user').should.not == nil
  end
end
