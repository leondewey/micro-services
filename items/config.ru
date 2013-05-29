$stdout.sync = true

require 'bundler'
Bundler.setup :default

%w{item item_representers api_v1 api}.each do |file|
  require "#{File.dirname(__FILE__)}/app/#{file}.rb"
end

run API