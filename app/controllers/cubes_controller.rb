class CubesController < ApplicationController
  before_action :set_cube, only: [:show, :edit, :update, :destroy, :add_archetype, :view, :remove_archetype]

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
      
      if cube.save!
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
  
  def remove_archetype
    respond_to do |format|
      ArchetypesInCube.where(cube_id: @cube.id, archetype_id: params[:archetype_id]).delete_all
      format.json { render :show, status: :ok, location: @cube }
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
  
  def view 
    colors = [:Black, :Blue, :Red, :White, :Green, :Colorless, :Multicolor ]
    cube_view = colors.inject({}) { |r, item| r[item] = { :Spells => [], :Creatures => []} ; r }
    cube_view[:Land] = []
    summary = { Spells: {}, Creatures: {} }
    repetition = []    
    
    fuse_cards = []
    @cube.archetypes.map { |a| a.cards }.flatten.each do |card|
      next if (repetition.include? card.id)
      
      repetition << card.id      
      color = nil      
      
      if (card.types.include? "Land")
        cube_view[:Land] << card
        summary[:Land] ||= 0
        summary[:Land] += 1
        summary[:Cards] ||= 0
        summary[:Cards] += 1
        next
      end

      
      if not card.fuse_id.nil?
        color = :Multicolor
        if fuse_cards.include? card.id
          next            
        else
          fuse_cards << card.fuse_id
        end
      elsif card.colors.size == 1     
        color = card.colors.first.to_sym
      elsif card.colors.size == 0
        color = :Colorless
      elsif card.colors.size > 1
        color = :Multicolor
      end
      
      if card.types.include? "Creature"
        summary[:Creatures][color] ||= 0
        summary[:Creatures][color] += 1
        cube_view[color][:Creatures] << card
      else
        summary[:Spells][color] ||= 0
        summary[:Spells][color] += 1
        cube_view[color][:Spells] << card
      end
      
      summary[color] ||= 0
      summary[color] += 1
      summary[:Cards] ||= 0
      summary[:Cards] += 1
      
    end
    
    cube_view.each { |color, map| map.each { |type, cards| cards.sort!{ |c1, c2| c1.cmc <=> c2.cmc } } if color != :Land }
    cube_view[:Total] = summary
    
    render text: cube_view.to_json
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
