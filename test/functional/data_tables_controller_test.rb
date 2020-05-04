require 'test_helper'

class DataTablesControllerTest < ActionController::TestCase
  setup do
    @data_table = data_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_table" do
    assert_difference('DataTable.count') do
      post :create, data_table: { age: @data_table.age, first_name: @data_table.first_name, id: @data_table.id, last_name: @data_table.last_name, position: @data_table.position, salary: @data_table.salary, starting_work: @data_table.starting_work }
    end

    assert_redirected_to data_table_path(assigns(:data_table))
  end

  test "should show data_table" do
    get :show, id: @data_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_table
    assert_response :success
  end

  test "should update data_table" do
    put :update, id: @data_table, data_table: { age: @data_table.age, first_name: @data_table.first_name, id: @data_table.id, last_name: @data_table.last_name, position: @data_table.position, salary: @data_table.salary, starting_work: @data_table.starting_work }
    assert_redirected_to data_table_path(assigns(:data_table))
  end

  test "should destroy data_table" do
    assert_difference('DataTable.count', -1) do
      delete :destroy, id: @data_table
    end

    assert_redirected_to data_tables_path
  end
end
