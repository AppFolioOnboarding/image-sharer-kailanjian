require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path

    assert_response :success
    assert_select 'h1', 'Image link submission'
    assert_select 'form'
  end

  def test_create
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: 'http://www.example.com/image.png' } }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal flash[:success], 'Successfully saved image'
  end

  def test_create__invalid_url
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { link: 'invalid' } }
    end

    assert_response :unprocessable_entity
    assert_select '.invalid-feedback', 'Link is invalid'
  end

end
