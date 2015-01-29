require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  test "should get _entry" do
    get :_entry
    assert_response :success
  end

end
