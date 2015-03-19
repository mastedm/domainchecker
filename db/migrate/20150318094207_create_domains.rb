class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.datetime :expiration_date
      t.string :comment

      t.timestamps null: false
    end
  end
end
