# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'


require 'sinatraapp/config'
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

    error 500 do
      status 500
    end

    helpers do
      include SinatraApp::Helper
    end

    def config
      config ||= SintaraApp::Config.new
    end


    not_found do 
      status 404
      erb :error_404
    end
    
    get '/' do
      erb :index
    end

    get '/images/:dir/:name' do
      send_file File.join(config.basedir, 'images',  params[:dir], params[:name])
    end

    post '/upload' do
      #500 unless request.env['HTTP_USER_AGENT'] == config.ua
      filename = config.filename
      path = config.path(filename: filename)
      config.make_dir(path: path)
      #FileUtils.cp(request[:image][:uploadfile].path, path)
  
      status 200
      #headers 'Content-Type' => 'text/plain'
      #body "#{config.url}/images/#{filename}"
    end

  end
end
