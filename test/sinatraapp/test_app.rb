# frozen_string_literal: true

require 'sinatraapp/test'
require 'flexmock/test_unit'


class TestApplication < SinatraApp::Test
  include Rack::Test::Methods
  def app
    @app
  end

  def config
    @config
  end
  
  def test_get_index
    get '/'
    assert_equal 200, last_response.status
  end

  def test_post_failure_the_image
    post '/upload'
    assert_equal 500, last_response.status
  end

  def test_post_success_the_image
    flexmock(config).should_receive(:dirname).returns('161104')
    flexmock(config).should_receive(:filename).returns('033fc4385c83dd48a34480eb8e8d8a03.png')
    flexmock(config).should_receive(:path).with('033fc4385c83dd48a34480eb8e8d8a03.png').returns('/home/www/gyazo_server/images/161104/033fc4385c83dd48a34480eb8e8d8a03.png')
    post '/upload', "imagedata" => Rack::Test::UploadedFile.new('images/test-image.png', 'image/png')
    assert_equal 200, last_response.status
  end
end
