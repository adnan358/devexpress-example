class CreateDataTables < ActiveRecord::Migration
  def self.up
    create_table :data_tables do |t|
      t.integer :id,  :null => false
      t.string :first_name,  :null => false
      t.string :last_name,  :null => false
      t.integer :age
      t.string :position
      t.date :starting_work,  :null => false
      t.integer :salary,  :null => false,  :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :data_tables
  end
end
