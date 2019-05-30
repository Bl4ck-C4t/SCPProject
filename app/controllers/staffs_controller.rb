
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
    id = params[:id]

    query = " SELECT staffs.id, staffs.name, staffs.position, sc.Name AS SecurityClearance, pc.ClearanceLevel AS PositionClearance
              FROM staffs
              INNER JOIN PositionClearance pc ON pc.PositionName = staffs.position
              INNER JOIN SecurityClearance sc ON sc.Level = pc.ClearanceLevel
              WHERE staffs.id = ?;"

    vals = [[nil, id]]

    @staff = ActiveRecord::Base.connection.exec_insert(query, "show", vals)[0]
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
    facility_query = "SELECT id, name FROM facilities;"
    @facilities = ActiveRecord::Base.connection.execute(facility_query)
    position_query = "SELECT * FROM PositionClearance;"
    @positions = ActiveRecord::Base.connection.execute(position_query)
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    name = params[:staff][:name]
    age = params[:staff][:age]
    position = params[:position]
    # query = "INSERT INTO staffs(name, age, position, created_at, updated_at) VALUES('" + name +  "',"+ age +",'"+ position +"', '', '')"
    query = "INSERT INTO staffs(name, age, position, FacilityId) VALUES(?, ?, ?, ?)"
    # vals = [ActiveRecord::Relation::QueryAttribute.new("String", name, Type::Value.new), Relation::QueryAttribute.new("number", age, Type::Value.new), 
    #   Relation::QueryAttribute.new("String", position, Type::Value.new)]
    vals = [[nil, name], [nil, age], [nil, position], [nil, params["facility"]]]
    result = ActiveRecord::Base.connection.exec_insert(query, "insert", vals)
    redirect_to staffs_path()
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    original_name = params[:staff][:original_name]
    name = params[:staff][:name]
    age = params[:staff][:age]
    position = params[:staff][:position]
        query = "UPDATE staffs SET name = ?, age = ?, position = ? WHERE name = ?;"
    # vals = [ActiveRecord::Relation::QueryAttribute.new("String", name, Type::Value.new), Relation::QueryAttribute.new("number", age, Type::Value.new), 
    #   Relation::QueryAttribute.new("String", position, Type::Value.new)]
    vals = [[nil, name], [nil, age], [nil, position], [nil, original_name]]
    result = ActiveRecord::Base.connection.exec_update(query, "update", vals)

  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    id = @staff.id
    query = "DELETE FROM staffs WHERE id = ?;"
    # vals = [ActiveRecord::Relation::QueryAttribute.new("String", name, Type::Value.new), Relation::QueryAttribute.new("number", age, Type::Value.new), 
    #   Relation::QueryAttribute.new("String", position, Type::Value.new)]
    vals = [[nil, params["id"]]]
    result = ActiveRecord::Base.connection.exec_delete(query, "insert", vals)

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
