class AddNextCheckDateToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :next_check_date, :datetime
  end
end
