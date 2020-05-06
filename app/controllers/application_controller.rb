class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @data_tables }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @data_table }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @data_table }
    end
  end

  def edit
    @data_table = DataTable.find(params[:id])
  end

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

  def destroy
    @data_table = DataTable.find(params[:id])
    @data_table.destroy

    respond_to do |format|
      format.html { redirect_to data_tables_url }
      format.json { head :no_content }
    end
  end

end
