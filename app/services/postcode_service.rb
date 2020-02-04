class PostcodeService
    API_SEARCH_URL = "http://postcodes.io/postcodes/"

    attr_accessor :postcode, :response, :whitelisted

    def initialize(postcode)
        @postcode = postcode
        @response = nil
        @whitelisted = false
    end

    def search
        if !white_listed?
            encoded_postcode = URI::encode(postcode.code)
            @response = HTTParty.get(API_SEARCH_URL+encoded_postcode)
        else
            @whitelisted = true
            {status: STATUSES[:found], postcode: white_listed?, lsoa: white_listed?.lsoa, errors: nil}
        end
    end

    def validate
        check_list = Lsoa.all
        r_lsoa = @response.dig("result","lsoa")
        # byebug
        return {status: STATUSES[:rejected], postcode: nil, lsoa: nil, errors: @response["error"]} unless @response["status"] == 200 || @response["error"] == "Postcode not found" 
            # byebug
        if r_lsoa
            validated = check_list.find do |white_listed_lsoa| 
                r_lsoa.include?(white_listed_lsoa.name)
            end
            if validated
                @postcode.lsoa = validated
                @postcode.save
               return to_whitelist = {status: STATUSES[:added], postcode: @response.dig("result","postcode"), lsoa: validated, errors: nil}
            end
            to_whitelist = {status: STATUSES[:rejected], postcode: @postcode, lsoa: nil, errors: "Not servicable"}
        else  
            custom_lsoa = Lsoa.find_by(name:"CUSTOM") || Lsoa.create(name:"CUSTOM")
            @postcode.lsoa = custom_lsoa
            @postcode.save
            to_whitelist = {status: STATUSES[:added], postcode: @postcode.code, lsoa: nil, errors: nil}
        end
    end

    def white_listed?
        Postcode.find_by(code: @postcode.code)
    end


    def execute
      ret = search
      !@whitelisted ? validate : ret
    end
    
end