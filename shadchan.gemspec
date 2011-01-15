# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shadchan/version"

Gem::Specification.new do |s|
  s.name        = "shadchan"
  s.version     = Shadchan::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vojtech Salbaba"]
  s.email       = ["darktatka@gmail.com"]
  s.homepage    = "http://github.com/DarkTatka/Shadchan"
  s.summary     = %q{Solves a stable marriage problem}
  s.description = %q{Solves a stable marriage problem}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
