window.Colors = ['Black', 'Blue', 'Red', 'White', 'Green', 'Colorless', 'Multicolor', 'Land']

class CubeBuilderApp
    
  constructor: (@cubeId) ->
    console.log("Cube Builder construtor")
    
    @wishlistView = new CubeBuilder.WishlistView(@cubeId)
    @cubeView = new CubeBuilder.CubeView(@cubeId, @wishlistView)
    @wishlistView.loadWishlist () => 
      @cubeView.render()
    
    @cubeFilter = new CubeBuilder.CubeFilter(@cubeId, @cubeView)
    
    @searchArchetypes = new CubeBuilder.SearchArchetypes(@cubeId, @cubeView)    
    @searchArchetypes.load =>
      @archetypesBadges = new CubeBuilder.ArchetypesBadges(@cubeId, @searchArchetypes, @cubeView)
      @searchArchetypes.archetypesBadges = @archetypesBadges
      @archetypesBadges.loadArchetype()      

      @cardShow = new CubeBuilder.CardShow(@archetypesBadges, @searchArchetypes, @cubeView, @cubeId, @wishlistView)
      @searchCard = new CubeBuilder.SearchCard(@archetypesBadges, @cardShow)
      
      @archetypesView = new CubeBuilder.ArchetypesView(@archetypesBadges)

class CubeViewApp
  constructor: (@cubeId) ->
    @cubeView = new CubeBuilder.CubeView(@cubeId, null)
    @cubeView.render()
    
$().ready ->
  cubeId = parseInt($("#cubeId").html())
  if (!isNaN(cubeId))
    cubeBuilder = new CubeBuilderApp(cubeId)
    
  cubeViewId = parseInt($("#cubeViewId").html())
  if (!isNaN(cubeViewId))
    cubeView = new CubeViewApp(cubeViewId)