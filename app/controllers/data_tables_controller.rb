class DataTablesController < ApplicationController
  # GET /data_tables
  # GET /data_tables.json


  def index
    @data_tables = DataTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @data_table }
    end
  end

  # GET /data_tables/1
  # GET /data_tables/1.json
  def show
    @data_table = DataTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @data_table }
    end
  end

  # GET /data_tables/new
  # GET /data_tables/new.json
  def new
    @data_table = DataTable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @data_table }
    end
  end

  # GET /data_tables/1/edit
  def edit
    @data_table = DataTable.find(params[:id])
  end

  # POST /data_tables
  # POST /data_tables.json
  def create
    @data_table = DataTable.new(params[:data_table])

    respond_to do |format|
      if @data_table.save
        format.html { redirect_to @data_table, notice: 'Data table was successfully created.' }
        format.json { render json: @data_table, status: :created, location: @data_table }
      else
        format.html { render action: "new" }
        format.json { render json: @data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /data_tables/1
  # PUT /data_tables/1.json
  def update
    @data_table = DataTable.find(params[:id])

    respond_to do |format|
      if @data_table.update_attributes(params[:data_table])
        format.html { redirect_to @data_table, notice: 'Data table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_tables/1
  # DELETE /data_tables/1.json
  def destroy
    @data_table = DataTable.find(params[:id])
    @data_table.destroy

    respond_to do |format|
      format.html { redirect_to data_tables_url }
      format.json { head :no_content }
    end
  end

  def prepare_data
    @table_hash = {}

    page = params[:skip].to_i == 0 ? 1 : (params[:skip].to_i / params[:take].to_i) + 1

    @search = DataTable.ransack
    data_table = @search.result.paginate(page: page, per_page: params[:take].to_i)

    hash = []
    data_table.each do |d|
      hash.push({
         "id" => d.id,
         "first_name" => "#{d.first_name}",
         "last_name" => "#{d.last_name}",
         "age" => d.age,
         "position" => "#{d.position}",
         "starting_work" => "#{d.starting_work}",
         "salary" => d.salary
     })
    end

    @table_hash[:data] = hash
    @table_hash[:totalCount] = DataTable.count if params[:requireTotalCount].present?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @table_hash }
    end
  end

end
