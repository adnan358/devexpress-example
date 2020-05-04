# Load the rails application
require File.expand_path('../application', __FILE__)
require File.expand_path('../initializers/mysql2_adapter', __FILE__)
# Initialize the rails application
DemoTable::Application.initialize!
