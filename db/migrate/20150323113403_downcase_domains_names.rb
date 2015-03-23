class DowncaseDomainsNames < ActiveRecord::Migration
  def change
  	Domain.all.each do |d|
      d.update_attributes name: d.name.downcase
    end
  end
end
