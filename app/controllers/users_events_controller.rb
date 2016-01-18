class UsersEventsController < ApplicationController
  before_action :set_users_event, only: [:show, :update, :destroy]

  # GET /users_events
  # GET /users_events.json
  def index
    @users_events = UsersEvent.all

    render json: @users_events
  end

  # GET /users_events/1
  # GET /users_events/1.json
  def show
    render json: @users_event
  end

  # POST /users_events
  # POST /users_events.json
  def create
    @users_event = UsersEvent.new(users_event_params)

    if @users_event.save
      render json: @users_event, status: :created, location: @users_event
    else
      render json: @users_event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users_events/1
  # PATCH/PUT /users_events/1.json
  def update
    @users_event = UsersEvent.find(params[:id])

    if @users_event.update(users_event_params)
      head :no_content
    else
      render json: @users_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users_events/1
  # DELETE /users_events/1.json
  def destroy
    @users_event.destroy

    head :no_content
  end

  private

    def set_users_event
      @users_event = UsersEvent.find(params[:id])
    end

    def users_event_params
      params.permit(:user_id, :event_id)
    end
end
