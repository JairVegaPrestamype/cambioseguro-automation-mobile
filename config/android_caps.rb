require 'dotenv/load'

module AndroidCaps
  def self.capabilities
    {
      platformName: 'Android',
      'appium:deviceName': ENV['ANDROID_DEVICE_NAME'] || 'Android Emulator',
      'appium:platformVersion': ENV['ANDROID_PLATFORM_VERSION'] || '13.0',
      'appium:automationName': 'UiAutomator2',
      'appium:app': ENV['ANDROID_APP_PATH'],
      'appium:appPackage': ENV['ANDROID_APP_PACKAGE'],
      'appium:appActivity': ENV['ANDROID_APP_ACTIVITY'],
      'appium:noReset': false,
      'appium:fullReset': false,
      'appium:autoGrantPermissions': true,
      'appium:newCommandTimeout': 300,
      'appium:adbExecTimeout': 20000,
      'appium:androidInstallTimeout': 90000,
      'appium:uiautomator2ServerInstallTimeout': 60000,
      # Performance settings
      'appium:skipServerInstallation': false,
      'appium:skipDeviceInitialization': false,
      # Additional settings
      'appium:unicodeKeyboard': true,
      'appium:resetKeyboard': true
    }
  end

  def self.appium_lib_opts
    {
      server_url: ENV['APPIUM_SERVER_URL'] || 'http://127.0.0.1:4723',
      wait_timeout: 10,
      wait_interval: 0.5
    }
  end
end
