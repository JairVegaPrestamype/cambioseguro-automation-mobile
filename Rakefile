require 'rspec/core/rake_task'
require 'colorize'

# Define RSpec tasks
RSpec::Core::RakeTask.new(:spec)

namespace :android do
  desc 'Run Android tests'
  RSpec::Core::RakeTask.new(:test) do |t|
    ENV['PLATFORM'] = 'android'
    t.pattern = 'spec/android/**/*_spec.rb'
    t.rspec_opts = '--format documentation --color'
  end

  desc 'Run Android smoke tests'
  RSpec::Core::RakeTask.new(:smoke) do |t|
    ENV['PLATFORM'] = 'android'
    t.pattern = 'spec/android/**/*_spec.rb'
    t.rspec_opts = '--format documentation --color --tag smoke'
  end
end

namespace :ios do
  desc 'Run iOS tests'
  RSpec::Core::RakeTask.new(:test) do |t|
    ENV['PLATFORM'] = 'ios'
    t.pattern = 'spec/ios/**/*_spec.rb'
    t.rspec_opts = '--format documentation --color'
  end

  desc 'Run iOS smoke tests'
  RSpec::Core::RakeTask.new(:smoke) do |t|
    ENV['PLATFORM'] = 'ios'
    t.pattern = 'spec/ios/**/*_spec.rb'
    t.rspec_opts = '--format documentation --color --tag smoke'
  end
end

desc 'Clean up screenshots and reports'
task :clean do
  puts 'Cleaning up test artifacts...'.yellow
  FileUtils.rm_rf('screenshots')
  FileUtils.rm_rf('reports')
  FileUtils.mkdir_p('screenshots')
  FileUtils.mkdir_p('reports')
  puts 'Clean up completed!'.green
end

desc 'Install dependencies'
task :setup do
  puts 'Installing Ruby dependencies...'.yellow
  system('bundle install')
  puts 'Setup completed!'.green
end

desc 'Check Appium doctor'
task :check_appium do
  puts 'Running appium-doctor...'.yellow
  system('appium-doctor')
end

task default: :spec
