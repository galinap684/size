class Collection < ApplicationRecord
  belongs_to :user
  has_many :collections_dresses
  has_many :dresses, through: :collections_dresses


end
