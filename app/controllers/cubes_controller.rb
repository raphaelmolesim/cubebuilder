class CubesController < ApplicationController
  before_action :set_cube, only: [:show, :edit, :update, :destroy, :add_archetype]

  skip_before_filter :authenticate

  # GET /cubes
  # GET /cubes.json
  def index
    @cubes = Cube.all
  end

  # GET /cubes/1
  # GET /cubes/1.json
  def show
  end

  # GET /cubes/new
  def new
    @cube = Cube.new
  end

  # GET /cubes/1/edit
  def edit
  end

  # POST /cubes
  # POST /cubes.json
  def create
    @cube = Cube.new(cube_params)

    respond_to do |format|
      if @cube.save
        format.html { redirect_to @cube, notice: 'Cube was successfully created.' }
        format.json { render :show, status: :created, location: @cube }
      else
        format.html { render :new }
        format.json { render json: @cube.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cubes/1
  # PATCH/PUT /cubes/1.json
  def update
    respond_to do |format|
      cube = Cube.find(params[:id])
      
      if true
        format.html { redirect_to @cube, notice: 'Cube was successfully updated.' }
        format.json { render :show, status: :ok, location: @cube }
      else
        format.html { render :edit }
        format.json { render json: @cube.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_archetype
    respond_to do |format|
      @cube.archetypes << Archetype.find(params[:archetype_id])
      
      if @cube.save!
        format.html { redirect_to @cube, notice: 'Cube was successfully updated.' }
        format.json { render :show, status: :ok, location: @cube }
      else
        format.html { render :edit }
        format.json { render json: @cube.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cubes/1
  # DELETE /cubes/1.json
  def destroy
    @cube.destroy
    respond_to do |format|
      format.html { redirect_to cubes_url, notice: 'Cube was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def set_wishlist  
    @cube = Cube.find(session[:cube_id])
    card = Card.find(params[:card_id])
    item = Wishlist.where(cube_id: @cube.id, card_id: card.id).first
    remove = params[:remove] == 'true'
    create = (not item and not remove)
    puts "====> #{item} params:#{remove}  #{create} #{(not item)} #{(not remove)} "
    if (item and remove)
      item.delete
    elsif (not item and not remove)
      Wishlist.create! cube: @cube, card: card
    end
    respond_to do |format|
      format.json { render :show, status: :ok, location: @cube }
    end    
  end
  
  def wishlist
    @cube = Cube.find(session[:cube_id])
    wishlist = @cube.wishlists.map(&:card_id)
    respond_to do |format|
      format.json { render json: wishlist, tatus: :ok }
    end     
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cube
      @cube = Cube.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cube_params
      params.require(:cube).permit(:name, :password, :cards => [])

    end
end
