class Dress < ApplicationRecord
  has_many :collections_dresses
  has_many :collections, through: :collections_dresses

  :add_pagination_methods
  self.per_page = 10

end
