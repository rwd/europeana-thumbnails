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

      def respond_with_redirects?
        ENV['RESPOND_WITH_REDIRECTS'].present?
      end

      get '/' do
        uri = params['uri']
        type = if params.key?('type') && %w(SOUND VIDEO TEXT 3D IMAGE).include?(params['type'].upcase)
                 params['type'].downcase
               else
                 'image'
               end
        size = params['size'] || 'FULL_DOC'

        resource_size = size =~ /w400/i ? 'LARGE' : 'MEDIUM'
        resource_path = Digest::MD5.hexdigest(uri) + '-' + resource_size
        resource_url = ENV['AMAZON_S3_URL'] + resource_path

        uri = URI.parse(resource_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        response = respond_with_redirects? ? http.head(uri.path) : http.get(uri.path)

        if (400..500).cover?(response.code.to_i)
          if respond_with_redirects?
            redirect to(generic_path), 302
          else
            generic_path = "/images/item-#{type}-large.gif"
            generic_filepath = File.expand_path("../../../../public#{generic_path}", __FILE__)
            send_file generic_filepath, type: 'image/gif'
          end
        else
          if respond_with_redirects?
            redirect to(resource_url), 302
          else
            headers response.header.to_hash.merge('Content-Type' => 'image/jpeg')
            status response.code
            body response.body
          end
        end
      end
    end
  end
end
