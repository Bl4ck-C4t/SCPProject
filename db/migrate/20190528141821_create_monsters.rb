class CreateMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :monsters do |t|

      t.timestamps
    end
  end
end
