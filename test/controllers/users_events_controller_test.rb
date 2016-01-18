require 'test_helper'

class UsersEventsControllerTest < ActionController::TestCase
  setup do
    @users_event = users_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_events)
  end

  test "should create users_event" do
    assert_difference('UsersEvent.count') do
      post :create, users_event: { event_id: @users_event.event_id, user_id: @users_event.user_id }
    end

    assert_response 201
  end

  test "should show users_event" do
    get :show, id: @users_event
    assert_response :success
  end

  test "should update users_event" do
    put :update, id: @users_event, users_event: { event_id: @users_event.event_id, user_id: @users_event.user_id }
    assert_response 204
  end

  test "should destroy users_event" do
    assert_difference('UsersEvent.count', -1) do
      delete :destroy, id: @users_event
    end

    assert_response 204
  end
end
