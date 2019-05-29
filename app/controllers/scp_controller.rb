class ScpController < ApplicationController
  def index
    query = "SELECT Id, Name FROM SCP"
    @scps = ActiveRecord::Base.connection.execute(query)
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
