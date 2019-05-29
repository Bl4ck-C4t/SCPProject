class DropFacilities < ActiveRecord::Migration[5.2]
  def change
  	execute <<-SQL
  		drop table facilities;
  	SQL
  end
end
