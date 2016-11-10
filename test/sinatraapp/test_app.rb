# frozen_string_literal: true

require 'sinatraapp/test'
require 'flexmock/test_unit'


class TestApplication < SinatraApp::Test
  include Rack::Test::Methods
  def app
    @app
  end

  def test_get_index
    get '/'
    assert_equal 200, last_response.status
  end

  def test_no_post_image_failure_upload
    post '/upload'
    assert_equal 500, last_response.status
  end

  def test_post_success_the_image
    post '/upload', "imagedata" => Rack::Test::UploadedFile.new('images/test-image.png', 'image/png')
    assert_equal 200, last_response.status
  end
end
