require_relative '../../base_page'

class IosLoginPage < BasePage
  # Locators - Update these based on your actual app
  USERNAME_FIELD = { type: :accessibility_id, value: 'username_input' }.freeze
  PASSWORD_FIELD = { type: :accessibility_id, value: 'password_input' }.freeze
  LOGIN_BUTTON = { type: :accessibility_id, value: 'login_btn' }.freeze
  ERROR_MESSAGE = { type: :accessibility_id, value: 'error_message' }.freeze
  FORGOT_PASSWORD_LINK = { type: :accessibility_id, value: 'forgot_password_link' }.freeze

  # Alternative locators using predicates
  # USERNAME_FIELD = { type: :predicate, value: 'name == "username_input"' }.freeze
  # PASSWORD_FIELD = { type: :predicate, value: 'name == "password_input"' }.freeze
  # LOGIN_BUTTON = { type: :predicate, value: 'name == "login_btn"' }.freeze

  def enter_username(username)
    send_keys_to_element(USERNAME_FIELD[:type], USERNAME_FIELD[:value], username)
  end

  def enter_password(password)
    send_keys_to_element(PASSWORD_FIELD[:type], PASSWORD_FIELD[:value], password)
  end

  def tap_login_button
    tap_element(LOGIN_BUTTON[:type], LOGIN_BUTTON[:value])
  end

  def login(username, password)
    enter_username(username)
    enter_password(password)
    hide_keyboard if keyboard_shown?
    tap_login_button
  end

  def error_message_displayed?
    element_displayed?(ERROR_MESSAGE[:type], ERROR_MESSAGE[:value])
  end

  def get_error_message
    get_text(ERROR_MESSAGE[:type], ERROR_MESSAGE[:value])
  end

  def tap_forgot_password
    tap_element(FORGOT_PASSWORD_LINK[:type], FORGOT_PASSWORD_LINK[:value])
  end

  def wait_for_login_screen
    wait_for_element(LOGIN_BUTTON[:type], LOGIN_BUTTON[:value])
  end
end
