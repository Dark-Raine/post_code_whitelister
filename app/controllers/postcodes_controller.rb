class PostcodesController < ApplicationController
    def index
        @postcodes = Postcode.all
    end

    def show
        @postcode = Postcode.find(params[:id])
    end

    def new
        @postcode = Postcode.new
    end
end