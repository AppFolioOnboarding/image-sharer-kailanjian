require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  def test_index__content
    get '/'

    assert_response :success
    assert_select 'h1', 'Hello, world'
    assert_select 'a' do
      assert_select '[href=?]', new_image_path
    end
  end

  def test_index__db_images
    Image.create!(link: 'http://www.image1.com', tag_list: 'hello')
    Image.create!(link: 'http://www.image2.com', tag_list: 'world')
    Image.create!(link: 'http://www.image3.com', tag_list: 'one, two, three').reload

    get '/'

    assert_response :success
    assert_select 'img', 3
    assert_select 'img' do |images|
      assert_equal images[0].attr('src'), 'http://www.image3.com'
      assert_equal images[1].attr('src'), 'http://www.image2.com'
      assert_equal images[2].attr('src'), 'http://www.image1.com'
    end
    assert_select 'a.badge' do |tags|
      assert_equal tags.map(&:text), %w[one two three world hello]
    end
  end

  def test_index__tag_filter_images
    Image.create(link: 'http://www.image1.com', tag_list: 'hello')
    Image.create(link: 'http://www.image2.com', tag_list: 'world')
    Image.create(link: 'http://www.image3.com', tag_list: 'one')
    Image.create(link: 'http://www.image4.com', tag_list: 'one, two, three')

    get '/images?tag=one'

    assert_response :success
    assert_select 'img', 2
    assert_select 'img' do |images|
      assert_equal images[0].attr('src'), 'http://www.image4.com'
      assert_equal images[1].attr('src'), 'http://www.image3.com'
    end
  end

  def test_index__invalid_tag
    get '/images?tag=nonexistent'

    assert_response :success
    assert_select 'p', 'No images found for tag "nonexistent"'
  end

  def test_new
    get new_image_path

    assert_response :success
    assert_select 'h1', 'Image link submission'
    assert_select 'input[type=text]' do
      assert_select '[name=?]', 'image[link]'
      assert_select '[name=?]', 'image[tag_list]'
    end
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

  def test_destroy
    image_to_destroy = Image.create!(link: 'http://www.example.com/imageD.png', tag_list: 'hello, world')
    Image.create!(link: 'http://www.example.com/image1.png', tag_list: 'hello, world')
    Image.create!(link: 'http://www.example.com/image2.png', tag_list: 'hello, world')
    Image.create!(link: 'http://www.example.com/image3.png', tag_list: 'hello, world')

    delete image_path(image_to_destroy)

    assert_redirected_to images_path
    follow_redirect!
    assert_select 'img', 3
    assert_select 'img' do |images|
      assert_equal images[0].attr('src'), 'http://www.example.com/image3.png'
      assert_equal images[1].attr('src'), 'http://www.example.com/image2.png'
      assert_equal images[2].attr('src'), 'http://www.example.com/image1.png'
    end
  end

  def test_destroy__invalid
    image_to_destroy = Image.create!(link: 'http://www.example.com/imageD.png', tag_list: 'hello, world')

    delete image_path(image_to_destroy)

    assert_raise(ActiveRecord::RecordNotFound) { delete image_path(image_to_destroy) }
  end

  def test_show
    image = Image.create!(link: 'http://www.example.com/image.png', tag_list: %w[hello world one])

    get image_path(image)

    assert_response :success
    assert_select 'img' do |images|
      assert_equal images[0].attr('src'), 'http://www.example.com/image.png'
    end
    assert_select 'a.badge' do |tags|
      assert_equal tags[0].text, 'hello'
      assert_equal tags[1].text, 'world'
      assert_equal tags[2].text, 'one'
    end
  end

  def test_show__no_tag
    image = Image.create!(link: 'http://www.example.com/image.png')

    get image_path(image)

    assert_response :success
    assert_select 'a.badge', 0
    assert_select 'img' do |images|
      assert_equal images[0].attr('src'), 'http://www.example.com/image.png'
    end
  end
end
