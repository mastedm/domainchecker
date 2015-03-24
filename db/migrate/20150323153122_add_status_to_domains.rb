class AddStatusToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :status, :string
  end
end
