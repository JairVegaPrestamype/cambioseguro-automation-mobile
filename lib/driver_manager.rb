require 'appium_lib'
require 'appium_lib_core'
require_relative '../config/appium_settings'
require_relative '../config/android_caps'
require_relative '../config/ios_caps'

class DriverManager
  @driver = nil

  class << self
    attr_reader :driver

    def start_driver(platform = nil)
      platform ||= AppiumSettings.platform
      
      puts "Starting Appium driver for platform: #{platform}"
      
      case platform.downcase
      when 'android'
        start_android_driver
      when 'ios'
        start_ios_driver
      else
        raise "Unsupported platform: #{platform}"
      end

      configure_implicit_wait
      @driver
    end

    def quit_driver
      if @driver
        puts 'Quitting Appium driver...'
        @driver.quit
        @driver = nil
      end
    end

    def reset_app
      @driver&.reset
    end

    def current_driver
      raise 'Driver not initialized. Call start_driver first.' unless @driver
      @driver
    end

    private

    def start_android_driver
      opts = {
        caps: AndroidCaps.capabilities,
        appium_lib: AndroidCaps.appium_lib_opts
      }
      
      @driver = Appium::Driver.new(opts, true).start_driver
    end

    def start_ios_driver
      opts = {
        caps: IosCaps.capabilities,
        appium_lib: IosCaps.appium_lib_opts
      }
      
      @driver = Appium::Driver.new(opts, true).start_driver
    end

    def configure_implicit_wait
      @driver.manage.timeouts.implicit_wait = AppiumSettings::IMPLICIT_WAIT
    rescue StandardError => e
      puts "Warning: Could not set implicit wait: #{e.message}"
    end
  end
end
