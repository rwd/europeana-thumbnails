# frozen_string_literal: true
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'europeana/thumbnails/app'
run Europeana::Thumbnails::App
