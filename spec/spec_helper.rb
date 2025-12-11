require 'rspec'
require 'appium_lib'
require_relative '../lib/driver_manager'
require_relative '../lib/helpers/screenshot_helper'
require_relative '../config/appium_settings'

RSpec.configure do |config|
  # RSpec configuration
  config.formatter = :documentation
  config.color = true
  config.tty = true
  
  # Expectations configuration
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Mocks configuration
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Before suite - runs once before all tests
  config.before(:suite) do
    puts "\n#{'=' * 80}"
    puts "Starting Test Suite for #{AppiumSettings.platform.upcase}"
    puts "#{'=' * 80}\n"
  end

  # Before each test
  config.before(:each) do |example|
    puts "\n#{'-' * 80}"
    puts "Starting Test: #{example.full_description}"
    puts "#{'-' * 80}\n"
    
    # Start driver before each test
    DriverManager.start_driver
  end

  # After each test
  config.after(:each) do |example|
    # Take screenshot on failure
    if example.exception && AppiumSettings::SCREENSHOT_ON_FAILURE
      test_name = example.full_description.gsub(/[^0-9A-Za-z]/, '_')
      ScreenshotHelper.take_screenshot(DriverManager.current_driver, "FAILED_#{test_name}")
    end

    # Quit driver after each test
    DriverManager.quit_driver

    puts "\n#{'-' * 80}"
    puts "Test Completed: #{example.full_description}"
    puts "Status: #{example.exception ? 'FAILED' : 'PASSED'}"
    puts "#{'-' * 80}\n"
  end

  # After suite - runs once after all tests
  config.after(:suite) do
    puts "\n#{'=' * 80}"
    puts 'Test Suite Completed'
    puts "#{'=' * 80}\n"
    
    # Clean old screenshots (older than 7 days)
    ScreenshotHelper.clean_old_screenshots(days: 7)
  end
end
