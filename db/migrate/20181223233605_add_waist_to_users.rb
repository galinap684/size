class AddWaistToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :waist, :integer
  end
end
