# Unguis

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
