class NewUserFormController < Formotion::FormController
  attr_accessor :parent

  def init
    @parent = parent
    forming = build_form
    initWithForm(forming)
  end

  def viewDidLoad
    super

    self.title = T7.t("Search GitHub")
  end

  def build_form
    new_form = Formotion::Form.new
    new_form.build_section do |section|
      section.title = T7.t("Find a github user")
      section.build_row do |row|
        row.key = "username"
        row.title = T7.t("Username")
        row.placeholder = T7.t("any name")
        row.type = :string
        row.on_enter do |r|
          submit
        end
      end

      section.build_row do |row|
        row.title = "Go"
        row.type = :submit
      end
    end

    new_form.on_submit do |f|
      submit
    end
    new_form
  end

  def submit
    data = self.form.render
    AFMotion::SessionClient.shared.get("users/#{data['username']}") do |result|
      if result.success?
        puts result.object.to_s
        user = User.new(result.object)
        @parent.user = user
        self.navigationController.popToRootViewControllerAnimated(true)
      else
        App.alert("Whoops couldn't find that githubber.")
      end
    end
  end

end
