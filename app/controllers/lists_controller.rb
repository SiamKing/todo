class ListsController < ApplicationController

    def index
        @lists = List.all
        @list = List.new
        # raise @lists.inspect
    end

    def show
        @list = List.find_by_id(params[:id])
    end

    def create
        @list = List.new(list_params)
        @list.save
        redirect_to list_path(@list)
    end


    private

    def list_params
        params.require(:list).permit(:name)
    end
end
