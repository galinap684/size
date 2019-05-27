class Dress < ApplicationRecord
  has_many :collections_dresses
  has_many :collections, through: :collections_dresses
end
