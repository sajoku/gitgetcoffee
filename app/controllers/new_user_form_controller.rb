class NewUserFormController < Formotion::FormController
  def init
    forming = build_form
    initWithForm(forming)
  end

  def build_form
    new_form = Formotion::Form.new
    new_form.build_section do |section|
      section.title = "Find a github user"
      section.build_row do |row|
        row.key = "username"
        row.title = "Username"
        row.placeholder = "any name"
        row.type = :string
        row.on_tap do |r|
          puts 'WAHT TAPPING'
        end
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
    puts data.to_s

    puts data['username']
    AFMotion::SessionClient.shared.get("users/#{data['username']}") do |result|
      if result.success?
        puts result.object.to_s
      end

    end

  end
end
