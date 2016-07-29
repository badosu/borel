task_file_pattern = File.expand_path("../lib/tasks/**/*.rb", __FILE__)
Dir[task_file_pattern].each do |task_file|
  require File.expand_path(task_file)
end

require 'bundler/gem_tasks'

task :default => [ :spec ]
