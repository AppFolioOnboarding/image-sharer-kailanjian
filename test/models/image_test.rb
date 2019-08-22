require 'test_helper'

class ImageTest < ActionDispatch::IntegrationTest
  def test_image__valid_url
    image = Image.new(link: 'http://www.example.com/image.png')

    assert image.valid?
  end

  def test_image__invalid_url
    image = Image.new(link: 'not a url')

    assert !image.valid?
  end
end
