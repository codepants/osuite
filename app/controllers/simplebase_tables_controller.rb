class SimplebaseTablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  def index
    @tables = SimplebaseTable.all
  end

  def show
    @records = @table.records.order(created_at: :desc)
  end

  def new
    @table = SimplebaseTable.new
  end

  def edit
  end

  def create
    @table = SimplebaseTable.new(table_params)
    if @table.save
      redirect_to @table, notice: 'Table was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @table.update(table_params)
      redirect_to @table, notice: 'Table was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @table.destroy
    redirect_to simplebase_tables_url, notice: 'Table was successfully deleted.'
  end

  private

  def set_table
    @table = SimplebaseTable.find(params[:id])
  end

  def table_params
    params.require(:simplebase_table).permit(:name, schema: {})
  end
end 