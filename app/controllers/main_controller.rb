class MainController < UIViewController
  include MainView

  def viewDidLoad
    super

    add_view_elements

    self.title = "GitGetCoffee"
    self.view.backgroundColor = UIColor.whiteColor

    true
  end

  def add_user(sender)
    controller = NewUserFormController.alloc.init
    self.navigationController.pushViewController(controller, animated: true)
  end

end
