require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get app' do
    get welcome_app_url
    assert_response :success
  end
end
