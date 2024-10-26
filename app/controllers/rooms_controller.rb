class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = Room.ordered.page(params[:page])
  end

  def show; end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: 'Room was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Room was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @room.update(room_params)
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: 'Room was successfully updated.' }
        # :notice is the key, the string is the value
        format.turbo_stream { flash.now[:notice] = 'The room has been successfully updated' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_path, notice: 'Room was successfully destroyed.' }
      format.turbo_stream do
        flash.now[:notice] = 'The room has been successfully deleted'
        render turbo_stream: turbo_stream.remove(@room) + turbo_stream.prepend('flash_messages',
                                                                               partial: 'layouts/flash')
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
