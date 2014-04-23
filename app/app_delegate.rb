class AppDelegate
  include SugarCube::Adjust
  attr_reader :root_controller
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @root_controller = UINavigationController.alloc.initWithRootViewController(main_controller)
    @window.rootViewController =  @root_controller
    @window.makeKeyAndVisible

    true
  end

  def main_controller
    @main_controller ||= MainController.alloc.init
  end
end
