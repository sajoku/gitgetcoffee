class AppDelegate
  include SugarCube::Adjust
  attr_reader :root_controller
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @client = AFMotion::SessionClient.build_shared("https://api.github.com") do
      session_configuration :default
      header "Accept", "application/json"
      response_serializer :json
    end

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
