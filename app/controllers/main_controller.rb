class MainController < UIViewController
  include MainView

  def viewDidLoad
    super

    add_view_elements

    self.title = "GitGetCoffee"

    true
  end

end
