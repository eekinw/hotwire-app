class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy]

    def index
        @rooms = Room.ordered
    end

    def show
    end

    def new
       @room = Room.new
    end

    def create
       @room = Room.new(room_params)

       if @room.save
           respond_to do |format|
            format.html { redirect_to rooms_path, notice: "Room was successfully created." }
            format.turbo_stream do
              render turbo_stream: turbo_stream.prepend("rooms", @room) + turbo_stream.update("new_room", "")
            end
        end
       else
           render :new
       end
    end

    def edit
    end

    def update
        if @room.update(room_params)
            respond_to do |format|
                format.html { redirect_to rooms_path, notice: "Room was successfully updated." }
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @room.destroy

        respond_to do |format|
            format.html { redirect_to rooms_path, notice: "Room was successfully destroyed." }
            format.turbo_stream do
                render turbo_stream: turbo_stream.remove(@room)
            end
        end
    end

    private

    def set_room
        @room = Room.find(params[:id])
    end

    def room_params
        params.require(:room).permit(:name)
    end
end
