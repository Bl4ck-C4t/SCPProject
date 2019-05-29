class CreateFacilities < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      create table facilities(
		id integer auto_increment primary key,
		name varchar(150) NOT NULL,
		capacity number(5) not null
		);
    SQL
    
  end
end
