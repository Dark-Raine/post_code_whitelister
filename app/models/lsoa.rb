class Lsoa < ApplicationRecord
    has_many :postcodes, dependent: :destroy
end
