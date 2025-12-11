require 'fileutils'

module ScreenshotHelper
  SCREENSHOTS_DIR = 'screenshots'.freeze

  def self.setup_screenshots_directory
    FileUtils.mkdir_p(SCREENSHOTS_DIR) unless Dir.exist?(SCREENSHOTS_DIR)
    
    # Create subdirectories by date
    date_dir = File.join(SCREENSHOTS_DIR, Time.now.strftime('%Y-%m-%d'))
    FileUtils.mkdir_p(date_dir) unless Dir.exist?(date_dir)
    date_dir
  end

  def self.take_screenshot(driver, name)
    setup_screenshots_directory
    
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    filename = "#{name.gsub(/[^0-9A-Za-z]/, '_')}_#{timestamp}.png"
    date_dir = File.join(SCREENSHOTS_DIR, Time.now.strftime('%Y-%m-%d'))
    filepath = File.join(date_dir, filename)
    
    driver.save_screenshot(filepath)
    puts "Screenshot saved: #{filepath}"
    filepath
  rescue StandardError => e
    puts "Failed to take screenshot: #{e.message}"
    nil
  end

  def self.clean_old_screenshots(days: 7)
    return unless Dir.exist?(SCREENSHOTS_DIR)

    cutoff_date = Time.now - (days * 24 * 60 * 60)
    
    Dir.glob(File.join(SCREENSHOTS_DIR, '*')).each do |dir|
      next unless File.directory?(dir)
      
      dir_date = File.basename(dir)
      begin
        dir_time = Time.parse(dir_date)
        FileUtils.rm_rf(dir) if dir_time < cutoff_date
      rescue ArgumentError
        # Skip directories that don't match date format
        next
      end
    end
  end
end
