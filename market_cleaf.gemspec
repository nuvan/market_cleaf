# Copyright (c) 2011 Nuno Valente
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require "rake"
require File.dirname(__FILE__) + "/lib/market_cleaf/version"

task :default => :spec

task :spec do
  # Run plain rspec command without RSpec::Core::RakeTask overrides.
  exec "rspec -c spec"
end

Gem::Specification.new do |s|
  s.name        = "market_cleaf"
  s.version     = MarketCleaf.version
  s.authors     = "Nuno Valente"
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.email       = "nuno.valente@gmail.com"
  s.homepage    = "http://github.com/nuvan/market_cleaf"
  s.summary     = ""
  s.description = ""

  s.rubyforge_project = "market_cleaf"

  #s.files         = Rake::FileList["[A-Z]*", "lib/**/*.rb", "lib/**/*.yml", "spec/*", ".gitignore"]
  s.files         = Rake::FileList["[A-Z]*", "lib/**/*.rb", "lib/**/*.yml", "spec/*"]
  s.test_files    = Rake::FileList["spec/*"]
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ">= 2.6.0"
end
