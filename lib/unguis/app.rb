# frozen_string_literal: true
require 'aws-sdk'
require 'newrelic_rpm'
require 'sinatra'
require 'unguis'

module Unguis
  ##
  # Sinatra app to respond to thumbnail requests
  class App < Sinatra::Base
    use Rack::Deflater

    set :public_folder, 'public'

    configure do
      set :s3, Aws::S3::Resource.new
      set :bucket, settings.s3.bucket(ENV['AMAZON_S3_BUCKET'])
      set :respond_with_redirects, ENV.key?('RESPOND_WITH_REDIRECTS')
    end

    TYPES = %w(SOUND VIDEO TEXT 3D IMAGE).freeze

    def generic_path
      type = if params.key?('type') && TYPES.include?(params['type'].upcase)
               params['type'].downcase
             else
               'image'
             end
      "/images/item-#{type}-large.gif"
    end

    get '/' do
      uri = params['uri']
      size = params['size'] || 'FULL_DOC'

      resource_size = size == 'w400' ? 'LARGE' : 'MEDIUM'
      resource_path = Digest::MD5.hexdigest(uri) + '-' + resource_size

      s3_object = settings.bucket.object(resource_path)

      if settings.respond_with_redirects
        redirect to(s3_object.exists? ? s3_object.public_url : generic_path), 302
      else
        begin
          s3_response = s3_object.get
          headers({
            'Content-Length' => s3_response.content_length,
            'Content-Type' => 'image/jpeg',
            'ETag' => s3_response.etag,
            'Last-Modified' => s3_response.last_modified.httpdate
          })
          status 200
          body s3_response.body
        rescue Aws::S3::Errors::NoSuchKey
          generic_filepath = File.expand_path("../../../../public#{generic_path}", __FILE__)
          send_file generic_filepath, type: 'image/gif'
        end
      end
    end
  end
end
