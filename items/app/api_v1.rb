require 'grape'

class APIv1 < Grape::API

  desc "All"
  get '/' do
    items = Item.all
    items = items.find :tags => params[:tags] if params[:tags]
    items.sort(:limit => [0, 10]).extend ItemColectionRepresenter
  end

  desc "Just one"
  params do
   requires :id, :type => Integer, :desc => "Item id."
  end
  get '/:id' do
    Item[params[:id]].extend ItemFullRepresenter
  end

  desc "Create"
  post '/' do
    Item.new(
      :data => params[:data],
      :tags => params[:tags]
    ).save.extend ItemRepresenter
  end

  desc "Delete"
  params do
   requires :id, :type => Integer, :desc => "Item id."
  end
  delete '/:id' do
    Item[params[:id]].delete
  end

  desc "Update"
  params do
   requires :id, :type => Integer, :desc => "Item id."
  end
  put '/:id' do
    item = Item[params[:id]]
    item.data = params[:data] if params[:data]
    item.tags = params[:tags] if params[:tags]
    item.save.extend ItemRepresenter
  end

end