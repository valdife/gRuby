require 'selenium-webdriver'
require 'webdrivers'


options = Selenium::WebDriver::Options.firefox
driver = Selenium::WebDriver.for :firefox, options: options
driver.manage.timeouts.implicit_wait = 50000
#driver.get(site)

#driver.quit
