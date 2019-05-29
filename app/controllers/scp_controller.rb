class ScpController < ApplicationController
  def index
    query = "SELECT Id, Name FROM SCP;"
    @scps = ActiveRecord::Base.connection.execute(query)
  end

  def show
    id = params[:id]

    query = " SELECT scp.Id, scp.Name, scp.Description, sc.Name AS SecurityClearance, ac.Name as AnomalyClass
              FROM SCP scp
              INNER JOIN SecurityClearance sc ON sc.Level = scp.SecurityClearanceNeeded
              INNER JOIN AnomalyClass ac ON ac.Id = scp.ClassId
              WHERE scp.Id = ?;"

    vals = [[nil, id]]

    @scp = ActiveRecord::Base.connection.exec_insert(query, "show", vals)[0]
  end


  def new
    name = params[:name]
    description = params[:description]
    clearance_level = params[:clearance_level]
    anomaly_class = params[:anomaly_class]

    query = " INSERT INTO SCP(Name, Description, SecurityClearanceNeeded, ClassId)
              VALUES(?, ?, ?, ?)"

    vals = [[nil, name], [nil, description], [nil, clearance_level], [nil, anomaly_class]]

    ActiveRecord::Base.connection.exec_insert(query, "show", vals)

    redirect_to controller: "scp", action: "index"
  end

  def create
    clearance_query = "SELECT Level, Name FROM SecurityClearance;"
    @clearance_levels = ActiveRecord::Base.connection.execute(clearance_query)

    class_query = "SELECT Id, Name FROM AnomalyClass;"
    @anomaly_classes = ActiveRecord::Base.connection.execute(class_query)
  end

  def update
  end

  def destroy
  end
end
