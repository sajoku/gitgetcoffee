include SugarCube::Adjust

class AppDelegate
  attr_reader :root_controller
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @client = AFMotion::SessionClient.build_shared("https://api.github.com") do
      session_configuration :default
      header "Accept", "application/json"
      response_serializer :json
    end

    T7.change_language('en') #Set the default language to english



    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @root_controller = UINavigationController.alloc.initWithRootViewController(main_controller)
    @window.rootViewController =  @root_controller
    @window.makeKeyAndVisible

    set_app_color

    true
  end

  private

  def main_controller
    @main_controller ||= MainController.alloc.init
  end

  def set_app_color
    UIApplication.sharedApplication.keyWindow.tintColor = UIColor.turquoiseColor
  end

end
