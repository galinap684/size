class AddRevolveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :revolve, :string
  end
end
