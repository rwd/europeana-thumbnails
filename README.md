# Unguis

[![Build Status](https://travis-ci.org/rwd/unguis.svg?branch=develop)](https://travis-ci.org/rwd/unguis) [![Coverage Status](https://coveralls.io/repos/github/rwd/unguis/badge.svg?branch=develop)](https://coveralls.io/github/rwd/unguis?branch=develop) [![security](https://hakiri.io/github/rwd/unguis/develop.svg)](https://hakiri.io/github/rwd/unguis/develop) [![Dependency Status](https://gemnasium.com/rwd/unguis.svg)](https://gemnasium.com/rwd/unguis) [![Code Climate](https://codeclimate.com/github/rwd/unguis/badges/gpa.svg)](https://codeclimate.com/github/codeclimate/codeclimate)

Sinatra app to serve thumbnails for web resources in [Europeana](http://www.europeana.eu/portal)

## Configuration

Thumbnails are expected to be stored in an Amazon S3 bucket.

Set the environment variable `AMAZON_S3_URL` to the full URL of the S3 bucket,
e.g. "https://europeana-thumbnails-production.s3.amazonaws.com/"

## Usage

Start the app using Puma: `bundle exec puma -C config/puma.rb`

Given your app is running on thumbs.example.com, and a web resource with URI
`http://provider.example.com/object/123.png`, request a thumbnail at:
`http://thumbs.example.com/?uri=http%3A%2F%2Fprovider.example.com%2Fobject%2F123.png`

## License

Licensed under the EUPL V.1.1.

For full details, see [LICENSE.md](LICENSE.md).
