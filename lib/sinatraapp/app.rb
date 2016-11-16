# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/contrib' 
require 'erubis'

require 'date'
require 'fileutils'
require 'digest'
require 'yaml'

require 'sinatraapp/helper'

module SinatraApp
  class Application < Sinatra::Base
    CONFIG = YAML.load_file(File.dirname(__FILE__) + '/../../config.yml')
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

    def url
      CONFIG['server']['url']
    end

    def basedir
      CONFIG['server']['basedir']
    end

    def dirname
      Date.today.strftime("%y%m%d")
    end

    def make_dir(path:)
      dir = File.dirname(path)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end

    def filename
      md5 = Digest::MD5.new
      md5.update((Time.now.to_i + :gyazo.object_id + rand(2^16)).to_s).hexdigest + '.png'
    end

    def path(filename:)
      File.join(basedir, dirname, filename)
    end


    def upload(upload_file:, path:)
      FileUtils.cp(upload_file, path)
    end

    not_found do 
      status 404
      erb :error_404
    end
    
    get '/' do
      erb :index
    end

    get '/images/:dir/:name' do
      send_file File.join(basedir, 'images',  params[:dir], params[:name])
    end

    post '/upload' do
      current_path = path(filename: filename)
      make_dir(path: current_path)
      upload(upload_file: request[:imagedata][:tempfile].path, path: current_path)
  
      status 200
      headers 'Content-Type' => 'text/plain'
      body "#{url}/images/#{filename}"
    end

  end
end
