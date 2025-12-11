require 'dotenv/load'

module AppiumSettings
  # Appium server configuration
  APPIUM_SERVER_URL = ENV['APPIUM_SERVER_URL'] || 'http://127.0.0.1:4723'

  # Timeout configuration
  IMPLICIT_WAIT = ENV['IMPLICIT_WAIT']&.to_i || 10
  EXPLICIT_WAIT = ENV['EXPLICIT_WAIT']&.to_i || 30

  # Screenshot configuration
  SCREENSHOT_ON_FAILURE = ENV['SCREENSHOT_ON_FAILURE'] == 'true'

  # Common Appium options
  APPIUM_OPTIONS = {
    wait_timeout: IMPLICIT_WAIT,
    wait_interval: 0.5
  }.freeze

  def self.platform
    ENV['PLATFORM']&.downcase || 'android'
  end

  def self.android?
    platform == 'android'
  end

  def self.ios?
    platform == 'ios'
  end
end
