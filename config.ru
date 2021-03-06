require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'

if ENV["RACK_ENV"] != "production"
  require 'sass/plugin/rack'
  Sass::Plugin.options[:style] = :compressed
  use Sass::Plugin::Rack
end

require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{.*}, 'http://trug.pl$&', :if => Proc.new { |rack_env|
    rack_env['SERVER_NAME'] == 'www.trug.pl'
  }
end

run App
