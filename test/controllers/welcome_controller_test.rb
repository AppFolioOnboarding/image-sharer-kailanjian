require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get welcome home page' do
    get '/'
    assert_response :success
  end

  test 'should get welcome home content' do
    get '/'
    assert_select 'h1', 'Hello, world'
    assert_select 'a' do
      assert_select '[href=?]', new_image_path
    end
  end
end
