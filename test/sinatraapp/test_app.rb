# frozen_string_literal: true

require 'sinatraapp/test'

class TestApplication < SinatraApp::Test
  include Rack::Test::Methods
  def app
    @app
  end

  def test_get_index
    get '/'
    assert_equal 200, last_response.status
  end
end
