class ScPsController < ApplicationController
  before_action :set_scp, only: [:show, :edit, :update, :destroy]

  # GET /scps
  # GET /scps.json
  def index
    @scps = Scp.all
  end

  # GET /scps/1
  # GET /scps/1.json
  def show
  end

  # GET /scps/new
  def new
    @scp = Scp.new
  end

  # GET /scps/1/edit
  def edit
  end

  # POST /scps
  # POST /scps.json
  def create
    @scp = Scp.new(scp_params)

    respond_to do |format|
      if @scp.save
        format.html { redirect_to @scp, notice: 'Scp was successfully created.' }
        format.json { render :show, status: :created, location: @scp }
      else
        format.html { render :new }
        format.json { render json: @scp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scps/1
  # PATCH/PUT /scps/1.json
  def update
    respond_to do |format|
      if @scp.update(scp_params)
        format.html { redirect_to @scp, notice: 'Scp was successfully updated.' }
        format.json { render :show, status: :ok, location: @scp }
      else
        format.html { render :edit }
        format.json { render json: @scp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scps/1
  # DELETE /scps/1.json
  def destroy
    @scp.destroy
    respond_to do |format|
      format.html { redirect_to scps_url, notice: 'Scp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scp
      @scp = Scp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scp_params
      params.fetch(:scp, {})
    end
end
