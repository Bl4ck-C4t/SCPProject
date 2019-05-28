class CreateScps < ActiveRecord::Migration[5.2]
  def change
    create_table :scps do |t|

      t.timestamps
    end
  end
end
