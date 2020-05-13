# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'progress_bar'
bar = ProgressBar.new(10000)
i = 1
10000.times do
  first_name = Faker::Name.unique.name
  last_name = Faker::Name.unique.name
  age = rand(18..70)
  position = Faker::Company.industry
  starting_work = Faker::Date.between(2.months.ago, Date.today)
  salary = rand(2000..5000)

  DataTable::create(first_name: first_name, last_name: last_name, age: age, position: position, starting_work: starting_work, salary: salary)
  bar.increment!
end