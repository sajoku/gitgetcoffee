# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require "motion/project/template/ios"
require "sugarcube"
require "sugarcube-repl"
require 'guard/motion'

begin
  require "bundler"
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = "gitgetcoffee"
  app.frameworks += ["Foundation"]

  app.deployment_target = "7.0"
  app.pods do
    pod 'FlatUIKit'
  end
end
