module GesturesHelper
  # Swipe gestures
  def swipe_up(duration: 1000)
    size = @driver.window_size
    start_x = size.width / 2
    start_y = size.height * 0.8
    end_y = size.height * 0.2
    
    swipe(start_x: start_x, start_y: start_y, end_x: start_x, end_y: end_y, duration: duration)
  end

  def swipe_down(duration: 1000)
    size = @driver.window_size
    start_x = size.width / 2
    start_y = size.height * 0.2
    end_y = size.height * 0.8
    
    swipe(start_x: start_x, start_y: start_y, end_x: start_x, end_y: end_y, duration: duration)
  end

  def swipe_left(duration: 1000)
    size = @driver.window_size
    start_x = size.width * 0.8
    start_y = size.height / 2
    end_x = size.width * 0.2
    
    swipe(start_x: start_x, start_y: start_y, end_x: end_x, end_y: start_y, duration: duration)
  end

  def swipe_right(duration: 1000)
    size = @driver.window_size
    start_x = size.width * 0.2
    start_y = size.height / 2
    end_x = size.width * 0.8
    
    swipe(start_x: start_x, start_y: start_y, end_x: end_x, end_y: start_y, duration: duration)
  end

  def swipe(start_x:, start_y:, end_x:, end_y:, duration: 1000)
    @driver.action
           .move_to_location(start_x, start_y)
           .pointer_down(:left)
           .pause(duration / 1000.0)
           .move_to_location(end_x, end_y)
           .release
           .perform
  end

  # Scroll methods
  def scroll_to_element(locator_type, locator_value, max_swipes: 10)
    max_swipes.times do
      return true if element_displayed?(locator_type, locator_value)
      swipe_up
    end
    false
  end

  def scroll_to_text(text, max_swipes: 10)
    if android?
      scroll_to_element(:uiautomator, "new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(text(\"#{text}\"))")
    else
      scroll_to_element(:accessibility_id, text, max_swipes: max_swipes)
    end
  end

  # Long press
  def long_press_element(locator_type, locator_value, duration: 2)
    element = find_element(locator_type, locator_value)
    location = element.location
    
    @driver.action
           .move_to_location(location.x, location.y)
           .pointer_down(:left)
           .pause(duration)
           .release
           .perform
  end

  # Tap by coordinates
  def tap_at_coordinates(x, y)
    @driver.action
           .move_to_location(x, y)
           .pointer_down(:left)
           .release
           .perform
  end

  # Double tap
  def double_tap_element(locator_type, locator_value)
    element = find_element(locator_type, locator_value)
    location = element.location
    
    2.times do
      @driver.action
             .move_to_location(location.x, location.y)
             .pointer_down(:left)
             .release
             .perform
      sleep 0.1
    end
  end

  # Drag and drop
  def drag_and_drop(source_locator_type, source_locator_value, target_locator_type, target_locator_value)
    source = find_element(source_locator_type, source_locator_value)
    target = find_element(target_locator_type, target_locator_value)
    
    @driver.action.click_and_hold(source).move_to(target).release.perform
  end
end
