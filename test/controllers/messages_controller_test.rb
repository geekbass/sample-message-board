require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get messages_url
    assert_response :success
  end

  test "should get new" do
    get new_message_url
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { body: @message.body } }
    end

    assert_redirected_to messages_url
  end

end
