$stdout.sync = true

require 'bundler'
Bundler.setup :default

%w{item api_v1 api}.each do |file|
  require "#{File.dirname(__FILE__)}/app/#{file}.rb"
end

map "/uploads" do
  run Rack::File.new("./uploads")
end

run API