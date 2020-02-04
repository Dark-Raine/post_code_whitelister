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

    def create
        # byebug
        postcode_search_result = PostcodeService.new(Postcode.build(postcode_params)).execute
        if postcode_search_result[:status] == STATUSES[:found]
            redirect_to new_postcode_path, notice: "Postcode whitelisted"
        elsif postcode_search_result[:status] == STATUSES[:rejected]
            redirect_to new_postcode_path, alert: postcode_search_result[:errors]
        end
    end

    def destroy
        Postcode.find(params[:id]).destroy
        redirect_to postcodes_path
    end

    private

    def postcode_params
        params.require(:postcode).permit(:code)
    end
end