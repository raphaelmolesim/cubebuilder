class ArchetypesController < ApplicationController
  before_action :set_archetype, only: [:show, :edit, :update, :destroy, :add_card]

  # GET /architypes
  # GET /architypes.json
  def index
    @archetypes = Archetype.eager_load(:selected_cards).eager_load(:cardsets)
    @archetypes.each { |a| a.selected_cards = a.selected_cards.select { |s| s.cube_id == session[:cube_id] } }
    
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @archetypes }
    end
  end

  # GET /architypes/1
  # GET /architypes/1.json
  def show
  end

  # GET /architypes/new
  def new
    @archetype = Archetype.new
  end

  # GET /architypes/1/edit
  def edit
  end

  # POST /architypes
  # POST /architypes.json
  def create
    @archetype = Archetype.new(architype_params)

    respond_to do |format|
      if @archetype.save
        format.html { redirect_to @archetype, notice: 'Architype was successfully created.' }
        format.json { render :show, status: :created, location: @archetype }
      else
        format.html { render :new }
        format.json { render json: @archetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /architypes/1
  # PATCH/PUT /architypes/1.json
  def update
    respond_to do |format|
      if @architype.update(architype_params)
        format.html { redirect_to @archetype, notice: 'Archetype was successfully updated.' }
        format.json { render :show, status: :ok, location: @archetype }
      else
        format.html { render :edit }
        format.json { render json: @archetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /architypes/1
  # DELETE /architypes/1.json
  def destroy
    @archetype.destroy
    respond_to do |format|
      format.html { redirect_to archetypes_url, notice: 'Archetype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def add_card
    card = Card.find(params[:card_id])
    Cardset.create!(card_id: card.id, archetype_id: @archetype.id)
    respond_to do |format|
      format.json { render :show, status: :ok, location: @archetype }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archetype
      @archetype = Archetype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def architype_params
      params.require(:archetype).permit(:name)
    end
end
