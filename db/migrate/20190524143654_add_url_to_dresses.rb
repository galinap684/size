class AddUrlToDresses < ActiveRecord::Migration[5.2]
  def change
    add_column :dresses, :url, :string
  end
end
