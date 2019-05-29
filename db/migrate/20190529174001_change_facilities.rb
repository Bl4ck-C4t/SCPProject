class ChangeFacilities < ActiveRecord::Migration[5.2]
  def change
  	<<-SQL
      alter table facilities(
		add id INTEGER PRIMARY KEY AUTOINCREMENT
		
		);
    SQL
  end
end
