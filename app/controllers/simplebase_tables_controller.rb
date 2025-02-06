class SimplebaseTablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  def index
    @simplebase_tables = SimplebaseTable.all.order(:name)
  end

  def show
    @records = @simplebase_table.records.order(created_at: :desc)
  end

  def new
    @simplebase_table = SimplebaseTable.new
  end

  def edit
  end

  def create
    @simplebase_table = SimplebaseTable.new(table_params)
    if @simplebase_table.save
      redirect_to @simplebase_table, notice: 'Table was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @simplebase_table.update(table_params)
      redirect_to @simplebase_table, notice: 'Table was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @simplebase_table.destroy
    redirect_to simplebase_tables_url, notice: 'Table was successfully deleted.'
  end

  private

  def set_table
    @simplebase_table = SimplebaseTable.find(params[:id])
  end

  def table_params
    params.require(:simplebase_table).permit(:name, :description, :schema)
  end
end 