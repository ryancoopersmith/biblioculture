class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.includes(:messages).find(params[:id])
    @message = Message.new
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      flash[:success] = 'Room added'
      @message = Message.new
      render action: 'show', id: @room.id
    else
      flash[:notice] = @room.errors.full_messages
      @room = Room.new
      render action: 'new'
    end
  end

  private

  def room_params
    params.require(:room).permit(:title)
  end
end
