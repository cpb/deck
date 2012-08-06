require 'sinatra/base'
require 'padrino-helpers'
require 'sinatra/flash'
require 'sass'
require 'coffee-script'
require_relative '../config/api_credentials'

module DeckApp

  class App < Sinatra::Application
    register Padrino::Helpers

    enable :sessions
    enable :logging

    set :client_id,     DeckApp::GAPI_CLIENT_ID
    set :client_secret, DeckApp::GAPI_CLIENT_SECRET

    enable :static
    set :root,           File.dirname(__FILE__)
    set :assets,         File.dirname(__FILE__) + '/assets/'
    set :public_folder,  settings.assets + '../public'

    helpers do
      def json_params
        @json_params ||= JSONParamsWrapper.new(request.body)
      end

      class JSONParamsWrapper
        def initialize(body)
          @parsed_request_body = JSON.parse(body.read)
        end

        def [](key)
          @parsed_request_body[key.to_s]
        end
      end
    end

    private

    # Checks the disk to see if the given filename exists as a scss spreadsheet
    #
    # Returns true if it does exist, false if not
    def stylesheet_exists?(asset)
      File.exists?(File.join(settings.root, settings.scss_dir, asset + ".scss"))
    end

    # Checks the disk to see if the given filename exists as coffeescript
    #
    # Returns true if it does exist, false if not
    def coffeescript_exists?(asset)
      File.exists?(File.join(settings.root, settings.coffee_dir, asset + ".coffee"))
    end

    def erb(file, *args)
      super(file.to_sym, *args)
    end
  end
end
