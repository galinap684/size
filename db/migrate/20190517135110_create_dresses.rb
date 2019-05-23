class CreateDresses < ActiveRecord::Migration[5.2]
  def change
    create_table :dresses do |t|

      t.string :name
      t.decimal :price
      t.string :brand
      t.string :color
      t.text :size, array: true, default: []

      t.timestamps
    end
  end
end
