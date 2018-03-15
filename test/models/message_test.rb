require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  setup do
    @message = Message.new
  end

  test 'Message cannot save with empty body' do
    @message.valid?
    assert_not_empty @message.errors
  end

  test 'Message can save with a valid body' do
    @message.body = 'Test Body'
    @message.valid?
    assert_empty @message.errors
  end

end
