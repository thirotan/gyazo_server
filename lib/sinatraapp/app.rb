require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'

require 'sinatraapp/model'
require 'sinatraapp/helper'

module SinatraApp
  class Application < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__) + '/../../'
      set :erb, escape_html: true
      set :public_folder, File.dirname(__FILE__) + '/../../public'
      enable :logging
      file = File.new("#{settings.root}/logs/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
    end

    helpers do
      include SinatraApp::Helper
    end

    def database
      @database ||= SintaraApp::Model.new
    end

    not_bound do 
      status 404
      erb :error_404
    end
    
    get '/' do
      erb :index
    end
  end
end
