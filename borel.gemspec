require File.expand_path('../lib/borel/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "borel"
  s.version = Borel.version
  s.platform = Gem::Platform::RUBY
  s.authors = ["Amadeus Folego"]
  s.email = ["amadeusfolego@gmail.com"]
  s.homepage = "http://github.com/amadeusfolego/borel"
  s.summary = "Union and intersection of intervals"
  s.description = s.summary
  s.rubyforge_project = s.name
  s.required_ruby_version = ">= 1.9.3"
  s.required_rubygems_version = ">= 1.3.6"
  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
