require 'grape'

class APIv1 < Grape::API

  desc "Create"
  post '/' do
    Item.create params[:file]
  end

  desc "Delete"
  params do
    requires :sha, :type => String, :desc => "Item sha."
  end
  delete '/:sha' do
    Item.delete params[:sha]
  end

end