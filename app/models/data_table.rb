class DataTable < ActiveRecord::Base
  self.table_name = 'data_tables'
  attr_accessible :age, :first_name, :id, :last_name, :position, :salary, :starting_work

end
