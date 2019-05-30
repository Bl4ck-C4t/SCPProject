class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    id = params[:id]

    query = "SELECT * FROM facilities"
   
    @facilities = Facility.find_by_sql(query)
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    id = params[:id]

    query = "SELECT fac.name, fac.capacity, ac.Name as AnomalyClass 
             FROM facilities fac
             INNER JOIN AnomalyClass ac ON ac.Id = fac.ClassId
             WHERE fac.Id = ?"

    vals = [[nil, id]]

    @facility = ActiveRecord::Base.connection.exec_insert(query, "show", vals)[0]
    query = "SELECT sc.Id, sc.Name 
             FROM SCP sc
             INNER JOIN facilities fac ON fac.Id = sc.ClassId;"
    @scps = ActiveRecord::Base.connection.execute(query)
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
    class_query = "SELECT Id, Name FROM AnomalyClass;"
    @anomaly_classes = ActiveRecord::Base.connection.execute(class_query)
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create
    name = params[:facility][:name]
    capacity = params[:facility][:capacity]
    anomaly_class = params[:anomaly_class]
    # query = "INSERT INTO staffs(name, age, position, created_at, updated_at) VALUES('" + name +  "',"+ age +",'"+ position +"', '', '')"
      query = "INSERT INTO facilities(id, name, capacity, ClassId) VALUES(NULL, ?, ?, ?)"
      # vals = [ActiveRecord::Relation::QueryAttribute.new("String", name, Type::Value.new), Relation::QueryAttribute.new("number", age, Type::Value.new), 
      #   Relation::QueryAttribute.new("String", position, Type::Value.new)]
      vals = [[nil, name], [nil, capacity], [nil, anomaly_class]]
    result = ActiveRecord::Base.connection.exec_insert(query, "insert facility", vals)
    redirect_to facilities_path()
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    id = params[:id]
    name = params[:facility][:name]
    capacity = params[:facility][:capacity]
    query = "UPDATE facilities SET name=?, capacity=? where id = ?;"
    vals = [[nil, name], [nil, capacity], [nil, id]]
    result = ActiveRecord::Base.connection.exec_update(query, "update facility", vals)
    redirect_to facility_path(id)
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    id = @facility.id
    query = "DELETE FROM facilities WHERE id = ?;"
    vals = [[nil, id]]
    result = ActiveRecord::Base.connection.exec_delete(query, "delete facility", vals)
    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:name, :capacity)
    end
end
