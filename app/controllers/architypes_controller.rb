class ArchitypesController < ApplicationController
  before_action :set_architype, only: [:show, :edit, :update, :destroy]

  # GET /architypes
  # GET /architypes.json
  def index
    @architypes = Architype.eager_load(:selected_cards).all
    
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @architypes }
    end
  end

  # GET /architypes/1
  # GET /architypes/1.json
  def show
  end

  # GET /architypes/new
  def new
    @architype = Architype.new
  end

  # GET /architypes/1/edit
  def edit
  end

  # POST /architypes
  # POST /architypes.json
  def create
    @architype = Architype.new(architype_params)

    respond_to do |format|
      if @architype.save
        format.html { redirect_to @architype, notice: 'Architype was successfully created.' }
        format.json { render :show, status: :created, location: @architype }
      else
        format.html { render :new }
        format.json { render json: @architype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /architypes/1
  # PATCH/PUT /architypes/1.json
  def update
    respond_to do |format|
      if @architype.update(architype_params)
        format.html { redirect_to @architype, notice: 'Architype was successfully updated.' }
        format.json { render :show, status: :ok, location: @architype }
      else
        format.html { render :edit }
        format.json { render json: @architype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /architypes/1
  # DELETE /architypes/1.json
  def destroy
    @architype.destroy
    respond_to do |format|
      format.html { redirect_to architypes_url, notice: 'Architype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_architype
      @architype = Architype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def architype_params
      params.require(:architype).permit(:name)
    end
end
