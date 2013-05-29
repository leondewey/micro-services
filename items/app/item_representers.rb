require 'representable'
require 'representable/json'
require 'representable/json/collection'
require 'roar'
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module ItemRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :tags

  link :self do
    "/v1/#{self.id}"
  end
end

module ItemFullRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia
  property :data
  include ItemRepresenter
end

module ItemColectionRepresenter
  include Representable::JSON::Collection
  items extend: ItemRepresenter, class: Item
end