class Postcode < ApplicationRecord
    belongs_to :lsoa
    FORMAT = /(^[A-Z])([A-Z0-9]{1,3})([0-9])([A-Z]{2})/i
    VALIDATOR = /(^[A-Z])([A-Z0-9]{1,3})([0-9])([A-Z]{2})/
    validate :verify_format
    validates :code, uniqueness: {case_sensitive: false, message: "already whitelisted"}

    def verify_format
        self.errors.add(:code, "That's an invalid postcode") if !verify?
    end

    def formatter
        cleaned = self.code.gsub(/[\s+\W]/, "")
        result = FORMAT.match(cleaned)
        self.code = result ? result.to_a[0].upcase : self.code
    end

    def verify?
        !!(VALIDATOR.match(self.code))
    end

    def self.build(code)
        new(code: code).tap do |postcode|
            postcode.formatter
        end
    end
end
