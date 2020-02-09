class BeerSerializer < ActiveModel::Serializer
  attributes :id, :id, :name, :tagline, :description, :abv, :iduser, :see_at, :favorite
end
