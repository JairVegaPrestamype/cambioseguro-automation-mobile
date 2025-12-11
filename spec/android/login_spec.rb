require 'spec_helper'
require_relative '../../lib/pages/android/login_page'

RSpec.describe 'Android Login Tests', :android do
  let(:login_page) { AndroidLoginPage.new }

  before(:each) do
    login_page.wait_for_login_screen
  end

  describe 'Login functionality' do
    it 'should login successfully with valid credentials', :smoke do
      # Arrange
      username = 'test_user'
      password = 'test_password'

      # Act
      login_page.login(username, password)

      # Assert
      # Add your assertion here based on your app
      # Example: expect(home_page.welcome_message_displayed?).to be true
      expect(true).to be true # Placeholder
    end

    it 'should show error message with invalid credentials' do
      # Arrange
      username = 'invalid_user'
      password = 'wrong_password'

      # Act
      login_page.login(username, password)

      # Assert
      expect(login_page.error_message_displayed?).to be true
      error_text = login_page.get_error_message
      expect(error_text).not_to be_empty
    end

    it 'should not login with empty username' do
      # Arrange
      password = 'test_password'

      # Act
      login_page.enter_password(password)
      login_page.tap_login_button

      # Assert
      expect(login_page.error_message_displayed?).to be true
    end

    it 'should not login with empty password' do
      # Arrange
      username = 'test_user'

      # Act
      login_page.enter_username(username)
      login_page.tap_login_button

      # Assert
      expect(login_page.error_message_displayed?).to be true
    end

    it 'should navigate to forgot password screen' do
      # Act
      login_page.tap_forgot_password

      # Assert
      # Add your assertion here based on your app
      # Example: expect(forgot_password_page.screen_displayed?).to be true
      expect(true).to be true # Placeholder
    end
  end

  describe 'Login screen elements' do
    it 'should display all login elements' do
      # Assert
      expect(login_page.element_displayed?(:id, 'com.example.app:id/username')).to be true
      expect(login_page.element_displayed?(:id, 'com.example.app:id/password')).to be true
      expect(login_page.element_displayed?(:id, 'com.example.app:id/login_button')).to be true
    end
  end
end
