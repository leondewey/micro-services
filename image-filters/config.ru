$stdout.sync = true

require 'bundler'
Bundler.setup :default
require 'sinatra'

%w{filters api}.each do |file|
  require "#{File.dirname(__FILE__)}/app/#{file}.rb"
end

run Sinatra::Application