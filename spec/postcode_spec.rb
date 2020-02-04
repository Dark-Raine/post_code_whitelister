require 'rails_helper'
# require 'byebug'
# byebug

describe Postcode do
    before :all do
        @valid_postcode = Postcode.new(code: "se16 2nw")
        @valid_postcode_special_chars = Postcode.new(code: "@£$%^&se16@2nw")
        @not_formatted_postcode = Postcode.new(code: "se16 2nw")
        @formatted_postcode = Postcode.new(code:"SE162NW")
        @built_postcode = Postcode.build(code: "se151du")
    end

    context("Formatter instance method") do
        it("Should format a valid postcode, without whitespace and be all capitials.") do
            expect(@valid_postcode.formatter).to eq("SE162NW")
        end
        it("Should format a valid postcode, removing any special characters.") do
            expect(@valid_postcode_special_chars.formatter).to eq("SE162NW")
        end
    end
    
    context("Verify? instance method") do
        it("Should determine if postcode is in the correct format to be saved") do
            expect(@formatted_postcode.verify?).to eq(true)
        end
        it("Should determine if postcode is in the incorrect format to not be saved") do
            expect(@not_formatted_postcode.verify?).to eq(false)
        end
    end

    context("verify format instance method") do
        it("Should not add errors to the instance when postcode format is correct") do
            @formatted_postcode.verify_format
            errors = @formatted_postcode.errors
            
            expect(errors.messages).to eq({})
        end
        it("Should correctly add errors to the instance when postcode format is incorrect") do
            @not_formatted_postcode.verify_format
            errors = @not_formatted_postcode.errors
            error_messages = errors.messages
            expect(error_messages).to eq({:code => ["That's an invalid postcode"]})
        end
    end

end