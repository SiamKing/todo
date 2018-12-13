class ItemsController < ApplicationController

    def create
        @list = List.find_by(id: params[:list_id])
        @item = @list.items.build(item_params)
        if @item.save
            redirect_to user_list_path(current_user, @list)
        else
            render "lists/show"
        end
    end

    # PATCH /lists/:id/items/:id
    def update
        @item = Item.find_by(id: params[:id])
        @item.update(item_params)
        redirect_to user_list_path(current_user, @item.list)
    end

    def destroy
        @item = Item.find_by(id: params[:id])
        @item.destroy

        redirect_to user_list_path(current_user, @item.list)
    end


    private

    def item_params
        params.require(:item).permit(:description, :status)
    end

end