# Unguis

[![Build Status](https://travis-ci.org/rwd/unguis.svg?branch=develop)](https://travis-ci.org/rwd/unguis) [![Coverage Status](https://coveralls.io/repos/github/rwd/unguis/badge.svg?branch=develop)](https://coveralls.io/github/rwd/unguis?branch=develop) [![security](https://hakiri.io/github/rwd/unguis/develop.svg)](https://hakiri.io/github/rwd/unguis/develop) [![Dependency Status](https://gemnasium.com/rwd/unguis.svg)](https://gemnasium.com/rwd/unguis) [![Code Climate](https://codeclimate.com/github/rwd/unguis/badges/gpa.svg)](https://codeclimate.com/github/codeclimate/codeclimate)

Sinatra app to serve thumbnails for web resources in [Europeana](http://www.europeana.eu/portal)

## Configuration

Thumbnails are expected to be stored in an Amazon S3 bucket.

This app uses the AWS SDK to connect to S3. You will need to configure in
environment variables:
* `AWS_REGION`: region of the S3 bucket
* `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: AWS credentials for read 
  access to objects in the bucket
* `AMAZON_S3_BUCKET`: name of the bucket

## Usage

Start the app using Puma: `bundle exec puma -C config/puma.rb`

Given your app is running on thumbs.example.com, and a web resource with URI
`http://provider.example.com/object/123.png`, request a thumbnail at:
`http://thumbs.example.com/?uri=http%3A%2F%2Fprovider.example.com%2Fobject%2F123.png`

### Response strategies

By default, Unguis will serve thumbnails in the HTTP response it sends to clients
itself.

Alternatively, it can be configured to respond with HTTP redirects to S3, by
setting the environment variable `RESPOND_WITH_REDIRECTS=1`.

### Caching thumbnails

Response headers include ETag and Last-Modified, facilitating client-side caching
of thumbnails.

## License

Licensed under the EUPL V.1.1.

For full details, see [LICENSE.md](LICENSE.md).
