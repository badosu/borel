require 'rspec/core/rake_task'

desc "Run specifications"
RSpec::Core::RakeTask.new {|r|
  r.rspec_opts = %w(--format documentation)
}
