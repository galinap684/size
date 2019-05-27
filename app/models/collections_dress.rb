class CollectionsDress < ApplicationRecord
  belongs_to :collection, required: false
  belongs_to :dresses, required: false

end
