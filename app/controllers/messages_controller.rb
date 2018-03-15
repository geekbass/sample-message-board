class MessagesController < ApplicationController

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.order(id: :desc).page(params[:page])
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: 'Message was successfully created.' }
        format.json { render :index, status: :created, location: messages_url }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:body)
  end

end
