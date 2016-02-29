class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events_to_me = Event.joins('LEFT OUTER JOIN events_users ON events_users.event_id = events.id').where("events_users.user_id=?", current_user.id)
    @events_from_me = Event.where(creator: current_user)

    @events = @events_to_me + @events_from_me
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render json: @event
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.creator = @current_user

    if @event.save
      @event.users.each do |user|
        p "event user = #{user.name}"
        user.send_event_push(PushTypes::NEW_EVENT, current_user.to_push, @event.title)
      end
    else
      render json: @event.errors, status: :unprocessable_entity
      return
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.permit(:title, :description, :image_url, user_ids: [])
  end
end
