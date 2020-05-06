class DataTablesController < ApplicationController
  before_filter :prepare_data

  def ajax_url
    prepare_data
  end
end

  private

  def prepare_data(limit = 50)
    data = DataTable.limit(limit)
    @data_table = []

    data.each do |e|
      @data_table.push({id: e.id, first_name: e.first_name, last_name: e.last_name, age: e.age, position: e.position, starting_work: e.starting_work, salary: e.salary})
    end
  end