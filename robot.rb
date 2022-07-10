require 'selenium-webdriver'
require 'webdrivers'
require './api_client.rb'

options = Selenium::WebDriver::Options.firefox
driver = Selenium::WebDriver.for :firefox, options: options
driver.manage.timeouts.implicit_wait = 10
exception = Selenium::WebDriver::Error::ElementClickInterceptedError

begin
    driver.get('https://glovoapp.com')
    wait = Selenium::WebDriver::Wait.new(timeout: 30, interval: 5, message: 'Timed out after 30 sec', ignore: exception)
    hello_button = driver.find_element(id: 'user-register', tag_name: "button")
    sleep(4)
    hello_button.click
    sleep(10)
    name_input = driver.find_element(class: 'el-input__inner', type: 'input')


ensure
    driver.quit
end