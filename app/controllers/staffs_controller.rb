
class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    query = "SELECT * FROM staffs"
    @staffs = Staff.find_by_sql(query)
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    name = params[:staff][:name]
    age = params[:staff][:age]
    position = params[:staff][:position]
    query = "INSERT INTO staffs(name, age, position, created_at, updated_at) VALUES('" + name +  "',"+ age +",'"+ position +"', '', '')"
    result = ActiveRecord::Base.connection.execute(query)
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    original_name = params[:staff][:original_name]
    name = params[:staff][:name]
    age = params[:staff][:age]
    position = params[:staff][:position]
    query = "UPDATE staffs SET name='" + name +  "', age="+ age +",position='"+ position +"' WHERE name = '" + original_name +"';"
    result = ActiveRecord::Base.connection.execute(query)
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:name, :age, :position)
    end
end
