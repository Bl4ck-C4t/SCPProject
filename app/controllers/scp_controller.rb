class ScpController < ApplicationController
  def index
    query = "SELECT Id, Name FROM SCP;"
    @scps = ActiveRecord::Base.connection.execute(query)
  end


  def show
    id = params[:id]

    query = " SELECT 
              scp.Id, scp.Name, scp.Description, sc.Name AS SecurityClearance, ac.Name as AnomalyClass,
              f.name AS FacilityName, f.id AS FacilityId

              FROM SCP scp
              LEFT JOIN SecurityClearance sc ON sc.Level = scp.SecurityClearanceNeeded
              LEFT JOIN AnomalyClass ac ON ac.Id = scp.ClassId
              LEFT JOIN facilities f ON f.id = scp.FacilityContainedId
              WHERE scp.Id = ?;"

    vals = [[nil, id]]

    @scp = ActiveRecord::Base.connection.exec_insert(query, "show", vals)[0]
  end


  def new
    name = params[:name]
    description = params[:description]
    clearance_level = params[:clearance_level]
    anomaly_class = params[:anomaly_class]
    facility = params[:facility]

    query = " INSERT INTO SCP(Name, Description, SecurityClearanceNeeded, ClassId, FacilityContainedId)
              VALUES(?, ?, ?, ?, ?)"

    vals = [[nil, name], [nil, description], [nil, clearance_level], [nil, anomaly_class], [nil, facility]]

    begin
      ActiveRecord::Base.connection.exec_insert(query, "create", vals)
      redirect_to controller: "scp", action: "index"
    rescue ActiveRecord::NotNullViolation => e
      redirect_to controller: "scp", action: "create"
    end
    
  end


  def create
    clearance_query = "SELECT Level, Name FROM SecurityClearance;"
    @clearance_levels = ActiveRecord::Base.connection.execute(clearance_query)

    class_query = "SELECT Id, Name FROM AnomalyClass;"
    @anomaly_classes = ActiveRecord::Base.connection.execute(class_query)

    facility_query = "SELECT id, name FROM facilities;"
    @facilities = ActiveRecord::Base.connection.execute(facility_query)
  end

  def edit
    clearance_query = "SELECT Level, Name FROM SecurityClearance;"
    @clearance_levels = ActiveRecord::Base.connection.execute(clearance_query)

    class_query = "SELECT Id, Name FROM AnomalyClass;"
    @anomaly_classes = ActiveRecord::Base.connection.execute(class_query)

    facility_query = "SELECT id, name FROM facilities;"
    @facilities = ActiveRecord::Base.connection.execute(facility_query)

    id = params[:id]


    query = " SELECT 
              scp.Id, scp.Name, scp.Description, scp.SecurityClearanceNeeded, scp.ClassId, scp.FacilityContainedId 
              FROM SCP
              WHERE scp.Id = ?;"

    vals = [[nil, id]]

    @scp = ActiveRecord::Base.connection.exec_insert(query, "update", vals)[0]
  end


  def update
    id = params[:id]
    name = params[:name]
    description = params[:description]
    clearance_level = params[:clearance_level]
    anomaly_class = params[:anomaly_class]
    facility = params[:facility]

    query = " UPDATE SCP
              SET 
              Name = ?,
              Description = ?,
              SecurityClearanceNeeded = ?,
              ClassId = ?,
              FacilityContainedId = ?
              WHERE Id = ?"

    vals = [
      [nil, name], [nil, description], [nil, clearance_level], [nil, anomaly_class], [nil, facility],[nil, id]
    ]

    begin
      ActiveRecord::Base.connection.exec_insert(query, "create", vals)
      redirect_to controller: "scp", action: "show", id: id
    rescue ActiveRecord::NotNullViolation => e
      redirect_to controller: "scp", action: "edit", id: id
    end
  end


  def destroy
    id = params[:id]

    query = "DELETE FROM SCP WHERE Id = ?;"
    vals = [[nil, id]]
    ActiveRecord::Base.connection.exec_insert(query, "destroy", vals)

    redirect_to controller: "scp", action: "index"
  end
end
