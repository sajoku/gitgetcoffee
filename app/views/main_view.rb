module MainView

  def add_view_elements
    self.navigationItem.rightBarButtonItem = add_user_button
  end

  def add_user_button
    @add_user_button ||= UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd,target: self, action: 'add_user:')
  end

end
