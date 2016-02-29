require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "event title and despription must not be empty" do
    event = Event.new
    assert event.invalid?
    assert event.errors[:title].any?
    assert event.errors[:description].any?
  end
end
