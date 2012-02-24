require './lib/borel/version.rb'

Gem::Specification.new do |s|
  s.name = "borel"
  s.version = Borel.version
  s.platform = Gem::Platform::RUBY
  s.authors = ["Amadeus Folego"]
  s.email = ["amadeusfolego@gmail.com"]
  s.homepage = "http://github.com/amadeusfolego/borel"
  s.summary = "Generic ordered set's operations"
  s.description = "Borel sets are made of enumerable union and intersection of
intervals. Borel performs regular operations on any interval of any
Comparable class."
  s.rubyforge_project = s.name
  s.required_ruby_version = ">= 1.9.3"
  s.required_rubygems_version = ">= 1.3.6"
  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
