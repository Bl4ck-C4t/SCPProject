class ReCreateFacilities < ActiveRecord::Migration[5.2]
  def change
  	execute <<-SQL
  		create table facilities(
		id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		name varchar(150) NOT NULL,
		capacity number(5) not null
		);
  	SQL
  end
end
