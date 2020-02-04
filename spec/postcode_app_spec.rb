require 'rails_helper'
describe "App usage scenario" do
    before :each do
        @driver = Selenium::WebDriver.for :chrome
        @base_url = "http://localhost:3000/postcodes"

    end
    
    context("Using the app to whitelist postcodes") do
        it("should be able to whitelist a postcode") do
            @driver.get(@base_url + "/new")
            sleep(3)
            @driver.find_element(:id, "postcode_code").click
            @driver.find_element(:id, "postcode_code").send_keys("se16 2nw")
            sleep(3)
            @driver.find_element(:name, "commit").click
            sleep(3)
            result = @driver.find_element(:tag_name, "h3").text
            expect(result).to eq("Postcode whitelisted")
        end
        
    end
end