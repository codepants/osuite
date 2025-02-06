class SimplebaseRecordsController < ApplicationController
  before_action :set_table
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  def index
    @records = @table.records.order(created_at: :desc)
  end

  def create
    @record = @table.records.build(record_params)
    if @record.save
      redirect_to simplebase_table_records_path(@table), notice: 'Record was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_table
    @table = SimplebaseTable.find(params[:simplebase_table_id])
  end

  def set_record
    @record = @table.records.find(params[:id])
  end

  def record_params
    params.require(:simplebase_record).permit(data: {})
  end
end 