module T7

  def self.e(message, replacements)
    replacements.each do |value, replacement|
      message = message.stringByReplacingOccurrencesOfString("##{value}#", withString: replacement )
    end

    message
  end

  def self.t(string)
    language.localizedStringForKey(string, value: nil, table: nil)
  end

  private

  def self.language
    @@language ||= NSBundle.bundleWithPath(language_path)
  end

  def self.language_path
    NSBundle.mainBundle.pathForResource(selected_language.first, ofType:"lproj")
  end

  def self.selected_language
    NSUserDefaults.standardUserDefaults.objectForKey("AppleLanguages")
  end

  def self.reset_language
    @@language = nil
  end

  def self.change_language(new_language)
    reset_language
    userDefaults = NSUserDefaults.standardUserDefaults
    userDefaults.setObject([new_language], forKey:"AppleLanguages")
    userDefaults.synchronize
  end

end

