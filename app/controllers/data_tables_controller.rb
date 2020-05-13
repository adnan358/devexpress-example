class DataTablesController < ApplicationController
  before_filter :prepare_filter_query, :create_paginate_variables, :prepare_filter_sort_array, :only => :prepare_data

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
    data_table = DataTable.new(params[:data_table])

    respond_to do |format|
      if data_table.save
        format.json { render json: response_hash(data_table), status: :created }
      else
        format.json { render json: data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /data_tables/1
  # PUT /data_tables/1.json
  def update
    data_table = DataTable.find(params[:id])

    respond_to do |format|
      if data_table.update_attributes(params[:data_table])
        format.json { render json: response_hash(data_table) }
      else
        format.json { render json: data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_tables/1
  # DELETE /data_tables/1.json
  def destroy
    data_table = DataTable.find(params[:id])
    data_table.destroy

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def bulk_delete
    DataTable.where(id: params[:ids]).delete_all

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def prepare_data
    @table_hash = {}
    @search = DataTable.ransack(@filter)
    @search.sorts = @sort
    data_table = @search.result.paginate(page: @page, per_page: @per_page)

    data = []
    data_table.each do |d|
      data.push({
         "id" => d.id,
         "first_name" => d.first_name,
         "last_name" => d.last_name,
         "age" => d.age,
         "position" => d.position,
         "starting_work" => d.starting_work,
         "salary" => d.salary
     })
    end

    # Devexpress data count for paginate
    total_count = { "totalCount" => data_table.count } if params[:requireTotalCount].present?
    summary = { "summary" => [data_table.count, data_table.sum(:salary)] }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: response_hash(data, {}, {}, total_count, summary) }
    end
  end

  private

  def prepare_filter_query
    matcher = ""
    find_search = ""
    @filter = {}

    (JSON::parse(params[:filter]) rescue []).each do |value|
      if value.kind_of?(Array)
        matcher += value.first + "_" rescue next
        find_search = value.last
      else
        matcher += value + "_" rescue next
      end
    end

    unless matcher.blank?
      matcher += "cont"
      @filter[matcher] = find_search
    end

  end

  def prepare_filter_sort_array
    @sort = []
    (JSON::parse(params[:sort]) rescue []).each do |value|
      sort_val = value["selector"] + " " + (value["desc"] ? "desc" : "asc")
      @sort.push(sort_val)
    end
  end

  def create_paginate_variables
    @page = params[:skip].to_i == 0 ? 1 : (params[:skip].to_i / params[:take].to_i) + 1
    @per_page = params[:take].to_i
  end

  def response_hash(data = {}, success = {}, error = {}, *args)
    response = {
        "data" => data,
        "success" => success,
        "error" => error
    }
    args.compact.each do |arg|
      response.merge!(arg)
    end

    response
  end

end
