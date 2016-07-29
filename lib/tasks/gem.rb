desc "Validate the gemspec"
task :gemspec do
  eval(File.read("borel.gemspec")).validate
end

desc "Launches interactive console with borel"
task console: :install do
  system "irb -r borel"
end
