# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatraapp/app'
require 'rack/protection'

use Rack::Protection::XSSHeader
use Rack::Protection::FrameOptions

run SinatraApp::Application
