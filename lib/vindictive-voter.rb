#encoding utf-8

require 'selenium-webdriver'

module VindictiveVoter
  class Runner
    def initialize(args=[])
      user = args[:user]     # the user we are being potentially vindictive against
      action = args[:action] # the action we will be taking (up, down) voting
      url = args[:url]     # the page to run against
      num_pages = args[:pages] || 0 # number of pages to turn and repeat
      delay = args[:delay] || 0.8

      if delay.is_a? String
        if delay.include? '.'
          delay = delay.to_f
        else
          delay = delay.to_i
        end
      end

      begin
        d = Selenium::WebDriver.for :chrome
        d.navigate.to 'https://www.reddit.com/login'
        d.find_element(:css, '#user_login').send_keys(ENV['VINDICTIVE_USER'])
        d.find_element(:css, '#passwd_login').send_keys(ENV['VINDICTIVE_PASS'])
        d.find_element(:css, '#login-form button[type="submit"]').click
        sleep 5
        d.navigate.to url

        arrow = ''
        case action
          when :up
            arrow = "[contains(@class, 'arrow up') and not(contains(@class, 'mod'))]"
          when :down
            arrow = "[contains(@class, 'arrow down') and not(contains(@class, 'mod'))]"
        end

        selectors = "//a[contains(@href,'#{user}')]/../../..//*#{arrow}"

        inv = false
        num_pages.times do
          d.find_elements(:xpath, selectors).each do |t|
            t.click
            sleep delay

            delay = delay.to_f + 0.1 if inv
            delay = delay.to_f - 0.1 unless inv
            inv = !inv
          end
          d.find_element(:css, "a[rel*='next']").click if num_pages > 1
          sleep 3
        end

      rescue Exception => e
        p e
        d.quit
      end
      d.quit
    end
  end
end
