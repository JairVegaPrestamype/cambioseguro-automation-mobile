require 'dotenv/load'

module IosCaps
  def self.capabilities
    {
      platformName: 'iOS',
      'appium:deviceName': ENV['IOS_DEVICE_NAME'] || 'iPhone 14',
      'appium:platformVersion': ENV['IOS_PLATFORM_VERSION'] || '16.0',
      'appium:automationName': 'XCUITest',
      'appium:app': ENV['IOS_APP_PATH'],
      'appium:bundleId': ENV['IOS_BUNDLE_ID'],
      'appium:noReset': false,
      'appium:fullReset': false,
      'appium:autoAcceptAlerts': true,
      'appium:autoDismissAlerts': false,
      'appium:newCommandTimeout': 300,
      # XCUITest specific settings
      'appium:wdaLaunchTimeout': 120000,
      'appium:wdaConnectionTimeout': 60000,
      'appium:usePrebuiltWDA': false,
      'appium:useNewWDA': false,
      # Performance settings
      'appium:skipServerInstallation': false,
      # Additional settings
      'appium:showIOSLog': false,
      'appium:clearSystemFiles': false
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
