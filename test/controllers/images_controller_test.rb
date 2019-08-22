require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_index__content
    get '/'

    assert_response :success
    assert_select 'h1', 'Hello, world'
    assert_select 'a' do
      assert_select '[href=?]', new_image_path
    end
  end

  def test_index__db_images
    Image.create(link: 'http://www.image1.com')
    Image.create(link: 'http://www.image2.com')
    Image.create(link: 'http://www.image3.com')

    get '/'

    assert_response :success
    assert_select 'img', 3
    assert_select 'img' do |images|
      assert_equal images[0].attr('src'), 'http://www.image3.com'
      assert_equal images[1].attr('src'), 'http://www.image2.com'
      assert_equal images[2].attr('src'), 'http://www.image1.com'
    end
  end

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

  def test_show
    image = Image.create!(link: 'http://www.example.com/image.png')

    get image_path(image)

    assert_response :success
    assert_select 'img' do
      assert_select '[src=?]', image.link
    end
  end
end