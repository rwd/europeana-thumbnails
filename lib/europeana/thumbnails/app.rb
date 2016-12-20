# frozen_string_literal: true
require 'newrelic_rpm'
require 'sinatra'
require 'europeana/thumbnails'

module Europeana
  module Thumbnails
    ##
    # Sinatra app to respond to thumbnail requests
    class App < Sinatra::Base
      set :public_folder, 'public'

      get '/' do
        uri = params['uri']
        type = if params.key?('type') && %w(SOUND VIDEO TEXT 3D IMAGE).include?(params['type'].upcase)
                 params['type'].downcase
               else
                 'image'
               end
        size = params['size'] || 'FULL_DOC'

        generic_path = "/images/item-#{type}-large.gif"
        generic_filepath = File.expand_path("../../../../public#{generic_path}", __FILE__)

        resource_size = size =~ /w400/i ? 'LARGE' : 'MEDIUM'
        resource_path = Digest::MD5.hexdigest(uri) + '-' + resource_size
        resource_url = ENV['AMAZON_S3_URL'] + resource_path
        # puts resource_url

        uri = URI.parse(resource_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        head_response = http.head(uri.path)

        if (400..500).cover?(head_response.code.to_i)
          send_file generic_filepath, type: 'image/gif'
          # redirect to(generic_path), 302
        else
          # headers head_response.header.to_hash.merge('Content-Type' => 'image/jpeg')
          # status head_response.code
          # body response.body
          redirect to(resource_url), 302
        end
      end
    end
  end
end
