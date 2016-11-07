# frozen_string_literal: true

require 'date'
require 'fileutils'
require 'digest'
require 'yaml'

module SinatraApp
  class Config
    attr_reader :url, :basedir, :ua

    def initialize
      config = YAML.load_file(File.dirname(__FILE__) + '/../../config.yml')
      @url = config['server']['url']
      @basedir = config['server']['basedir']
      @ua = config['client']['ua']
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

  end
end
