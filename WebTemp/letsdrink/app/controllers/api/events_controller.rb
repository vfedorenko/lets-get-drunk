class Api::EventsController < ApplicationController
  respond_to :json

	def index
    respond_with Event.all
  end
 
  def show
    respond_with Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
 
    if @event.save
      render json: @event, status: 201, location: [:api, @event]
    else
      render json: { errors: @event.errors }, status: 422
    end
  end
 
  def update
    @event = Event.find(params[:id])
 
    if @event.update(event_params)
      render json: @event, status: 200, location: [:api, @event]
    else
      render json: { errors: @event.errors }, status: 422
    end
  end
 
  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      render status 200
    else
      render status 404
    end
  end
 
  private
    def event_params
      params.require(:event).permit(:title, :description)
    end
end
