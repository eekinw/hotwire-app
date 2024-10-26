class MessagesController < ApplicationController
  before_action :set_room, only: %i[new create destroy]

  def new
    @message = @room.messages.new
  end

  def create
    @message = @room.messages.new(message_params)

    if @message.save
      respond_to do |format|
        format.html { redirect_to room_path(@room) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @room = @message.room
    @message.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@message) {
                               flash.now[:notice] = 'The message has been successfully deleted'
                             }
      end
      format.html { redirect_to @room, notice: 'Message was successfully destroyed.' }
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
