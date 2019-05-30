class Nw2 < ActiveRecord::Migration[5.2]
  def change
  	execute <<-SQL
		create table facilities(
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			name varchar(150) NOT NULL,
			capacity number(5) not null,
			ClassId  INTEGER not null,
			foreign key(ClassId) references AnomalyClass(Id)

		);
    SQL
  end
end
