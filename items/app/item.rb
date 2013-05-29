require 'ohm'
require 'multi_json'

Ohm.connect

class Item < Ohm::Model
  attribute :data_serialized
  attribute :tags
  index :tags

  def data
    MultiJson.load @attributes[:data_serialized]
  end

  def data=(obj)
    @attributes[:data_serialized] = MultiJson.dump obj
  end

end