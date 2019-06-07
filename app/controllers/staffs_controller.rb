
class StaffsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :permission_denied
  before_action :set_staff, only: [:show, :edit, :update, :destroy] 
  skip_before_action :verify_authenticity_token 

  def permission_denied
    redirect_to(root_path, status: 401)
  end

  # GET /staffs
  # GET /staffs.json
  def index
    id = params[:id]
    @staffs = pagination("staffs", "staffs.name")
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    id = params[:id]

    query = " SELECT staffs.id, staffs.age, staffs.name, staffs.positionId, sc.Name AS SecurityClearance, pc.PositionName AS PositionClearance, f.name as FacilityName, staffs.facilityId 
              FROM staffs
              INNER JOIN PositionClearance pc ON pc.PositionId = staffs.positionId
              INNER JOIN SecurityClearance sc ON sc.Level = pc.ClearanceLevel
	      INNER JOIN facilities f ON f.Id = staffs.facilityId
              WHERE staffs.id = ?;"

    vals = [[nil, id]]
    @staff = ActiveRecord::Base.connection.exec_insert(query, "show", vals)[0]
    puts @staff

    if(params[:api])
      render json: { 
             "name" => @staff["name"],
             "age" => @staff["age"],
             "PositionClearance" => @staff["PositionClearance"],
	     "FacilityName" => @staff["FacilityName"]
          }.to_json, status: 200
      return
    end

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
    facility_query = "SELECT id, name FROM facilities;"
    @facilities = ActiveRecord::Base.connection.execute(facility_query)
    position_query = "SELECT * FROM PositionClearance;"
    @positions = ActiveRecord::Base.connection.execute(position_query)
  end

  # POST /staffs
  # POST /staffs.json
  def create
   if(params["api"])
      name = params[:name]
      age = params[:age]
      position = params[:position]
    else
      name = params[:staff][:name]
      age = params[:staff][:age]
      position = params[:position]
    end
    
    # query = "INSERT INTO staffs(name, age, position, created_at, updated_at) VALUES('" + name +  "',"+ age +",'"+ position +"', '', '')"
    query = "INSERT INTO staffs(name, age, positionId, FacilityId) VALUES(?, ?, ?, ?)"
    # vals = [ActiveRecord::Relation::QueryAttribute.new("String", name, Type::Value.new), Relation::QueryAttribute.new("number", age, Type::Value.new), 
    #   Relation::QueryAttribute.new("String", position, Type::Value.new)]
    vals = [[nil, name], [nil, age], [nil, position], [nil, params["facility"]]]
    result = ActiveRecord::Base.connection.exec_insert(query, "insert", vals)
    if(params["api"])
      head :created, location: "Somewhere"
      return
    else
      redirect_to staffs_path()
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    id = params[:id]
    if(params["api"])
      name = params["name"]
      age = params["age"].to_i
      position = params["position"].to_i
    else
      name = params[:staff][:name]
      age = params[:staff][:age]
      position = params[:position]
    end
    
        query = "UPDATE staffs SET name = ?, age = ?, positionId = ?, FacilityId = ? WHERE id = ?;"
    # vals = [ActiveRecord::Relation::QueryAttribute.new("String", name, Type::Value.new), Relation::QueryAttribute.new("number", age, Type::Value.new), 
    #   Relation::QueryAttribute.new("String", position, Type::Value.new)]
    vals = [[nil, name], [nil, age], [nil, position], [nil, params["facility"].to_i], [nil, id]]
    result = ActiveRecord::Base.connection.exec_update(query, "update", vals)
    if(params["api"])
      head :updated, location: "Somewhere"
      return
    else
      redirect_to staffs_path()
    end

  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy

    if(params["api"])
      id = params[:id]
    else
      id = @staff.id
    end
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
      params.require(:staff).permit(:name, :age, :positionId)
    end
end
