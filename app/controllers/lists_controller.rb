class ListsController < ApplicationController

    def index
        @lists = List.all
        @list = List.new
        # raise @lists.inspect
    end

    def show
        @list = List.find_by_id(params[:id])
        @item = @list.items.build
    end

    def create
        @list = List.new(list_params)
        if @list.save
            redirect_to list_path(@list)
        else
            @lists = List.all
            render :index
        end
    end

    private

    def list_params
        params.require(:list).permit(:name)
    end
end
