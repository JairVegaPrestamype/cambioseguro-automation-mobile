require_relative 'driver_manager'
require_relative 'helpers/gestures_helper'
require_relative '../config/appium_settings'

class BasePage
  include GesturesHelper

  def initialize
    @driver = DriverManager.current_driver
  end

  # Element interaction methods
  def find_element(locator_type, locator_value)
    @driver.find_element(locator_type, locator_value)
  end

  def find_elements(locator_type, locator_value)
    @driver.find_elements(locator_type, locator_value)
  end

  def tap_element(locator_type, locator_value)
    element = wait_for_element(locator_type, locator_value)
    element.click
  end

  def send_keys_to_element(locator_type, locator_value, text)
    element = wait_for_element(locator_type, locator_value)
    element.clear
    element.send_keys(text)
  end

  def get_text(locator_type, locator_value)
    element = wait_for_element(locator_type, locator_value)
    element.text
  end

  def element_displayed?(locator_type, locator_value)
    wait_for_element(locator_type, locator_value, timeout: 5)
    true
  rescue Selenium::WebDriver::Error::TimeoutError
    false
  end

  def element_enabled?(locator_type, locator_value)
    element = find_element(locator_type, locator_value)
    element.enabled?
  end

  # Wait methods
  def wait_for_element(locator_type, locator_value, timeout: AppiumSettings::EXPLICIT_WAIT)
    wait = Selenium::WebDriver::Wait.new(timeout: timeout)
    wait.until { @driver.find_element(locator_type, locator_value) }
  end

  def wait_for_element_not_present(locator_type, locator_value, timeout: AppiumSettings::EXPLICIT_WAIT)
    wait = Selenium::WebDriver::Wait.new(timeout: timeout)
    wait.until do
      @driver.find_elements(locator_type, locator_value).empty?
    rescue Selenium::WebDriver::Error::NoSuchElementError
      true
    end
  end

  def wait_for_element_clickable(locator_type, locator_value, timeout: AppiumSettings::EXPLICIT_WAIT)
    wait = Selenium::WebDriver::Wait.new(timeout: timeout)
    wait.until do
      element = @driver.find_element(locator_type, locator_value)
      element.displayed? && element.enabled?
    end
  end

  # Navigation methods
  def go_back
    @driver.back
  end

  def hide_keyboard
    @driver.hide_keyboard if keyboard_shown?
  rescue StandardError => e
    puts "Could not hide keyboard: #{e.message}"
  end

  def keyboard_shown?
    @driver.is_keyboard_shown
  rescue StandardError
    false
  end

  # Platform-specific helpers
  def android?
    AppiumSettings.android?
  end

  def ios?
    AppiumSettings.ios?
  end

  # Context switching (for hybrid apps)
  def switch_to_webview
    available_contexts = @driver.available_contexts
    webview_context = available_contexts.find { |context| context.start_with?('WEBVIEW') }
    @driver.set_context(webview_context) if webview_context
  end

  def switch_to_native
    @driver.set_context('NATIVE_APP')
  end

  # Screenshot helper
  def take_screenshot(filename)
    screenshots_dir = 'screenshots'
    Dir.mkdir(screenshots_dir) unless Dir.exist?(screenshots_dir)
    
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    filepath = File.join(screenshots_dir, "#{filename}_#{timestamp}.png")
    
    @driver.save_screenshot(filepath)
    puts "Screenshot saved: #{filepath}"
    filepath
  end
end
