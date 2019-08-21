require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path

    assert_response :success
    assert_select 'h1', 'Image link submission'
    assert_select 'form'
  end
end
