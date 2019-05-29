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

  def create
  end

  def update
  end

  def destroy
  end
end
