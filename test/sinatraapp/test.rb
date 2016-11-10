# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'logger'
require 'rack/test'
require 'yaml'

require 'sinatraapp/app'
require 'sinatraapp/config'

module SinatraApp
  class Test < Test::Unit::TestCase
    def setup
      @app = SinatraApp::Application
    end
  end
end
