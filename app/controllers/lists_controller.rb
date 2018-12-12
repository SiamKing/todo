class ListsController < ApplicationController
    before_action :authentication_required

    def index
        @lists = current_user.lists
        @list = List.new
        # raise @lists.inspect
    end

    def show
        @list = List.find_by_id(params[:id])
        @item = Item.new
    end

    def create
        @list = List.new(list_params)
        if @list.save
            redirect_to list_path(@list)
        else
            @lists = current_user.lists
            render :index
        end
    end

    private

    def list_params
        params.require(:list).permit(:name)
    end
end
