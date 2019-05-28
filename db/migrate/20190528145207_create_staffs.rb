class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :name
      t.integer :age
      t.string :position

      t.timestamps
    end
  end
end
