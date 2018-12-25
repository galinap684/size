class AddBustToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bust, :integer
  end
end
