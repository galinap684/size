class CreateCollectionsDresses < ActiveRecord::Migration[5.2]
  def change
    create_table :collections_dresses do |t|


      t.belongs_to :dress, index: true
      t.belongs_to :collection, index: true

      t.timestamps
    end
  end
end
