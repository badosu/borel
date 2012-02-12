gemspec = eval(File.read("borel.gemspec"))

desc "Validate the gemspec"
task :gemspec do
  gemspec.validate
end

desc "Build gem locally"
task :build => :gemspec do
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir_p "pkg"
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
end

desc "Install gem locally"
task :install => :build do
  system "gem install pkg/#{gemspec.name}-#{gemspec.version}"
end

desc "Launches interactive console with borel"
task :console => :install do
  system "irb -r #{gemspec.name}"
end

desc "Clean automatically generated files"
task :clean do
  FileUtils.rm_rf "pkg"
end
