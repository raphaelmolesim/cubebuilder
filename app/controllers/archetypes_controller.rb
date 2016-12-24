class ArchetypesController < ApplicationController
  before_action :set_archetype, only: [:show, :edit, :update, :destroy, :add_card, :remove_card]

  # GET /archetypes
  # GET /archetypes.json
  def index
    if (params[:all] == "true")
      @archetypes = Archetype.all
    else
      @archetypes = Cube.eager_load(:archetypes_in_cubes).find(session[:cube_id]).archetypes
    end

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @archetypes }
    end
  end

  # GET /archetypes/1
  # GET /archetypes/1.json
  def show
  end

  # GET /archetypes/new
  def new
    @archetype = Archetype.new
  end

  # GET /archetypes/1/edit
  def edit
  end

  # POST /archetypes
  # POST /archetypes.json
  def create
    @archetype = Archetype.new(archetype_params)

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

  # PATCH/PUT /archetypes/1
  # PATCH/PUT /archetypes/1.json
  def update
    respond_to do |format|
      if @archetype.update(archetype_params)
        format.html { redirect_to @archetype, notice: 'Archetype was successfully updated.' }
        format.json { render :show, status: :ok, location: @archetype }
      else
        format.html { render :edit }
        format.json { render json: @archetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archetypes/1
  # DELETE /archetypes/1.json
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
      format.json { render json: @archetype , status: :ok}
    end
  end
  
  def remove_card
    card = Card.find(params[:card_id])
    puts "  => #{card} #{params[:card_id]}"
    Cardset.where(card_id: card.id, archetype_id: @archetype.id).delete_all
    respond_to do |format|
      format.json { render json: @archetype , status: :ok}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archetype
      @archetype = Archetype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def archetype_params
      params.require(:archetype).permit(:name)
    end
end
