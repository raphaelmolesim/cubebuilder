window.Colors = ['Black', 'Blue', 'Red', 'White', 'Green', 'Colorless', 'Multicolor', 'Land']

class CubeBuilderApp
    
  constructor: (@cubeId) ->
    console.log("Cube Builder construtor")
    
    @cubeView = new CubeBuilder.CubeView(@cubeId)
    @cubeView.render()
    
    @wishlistView = new CubeBuilder.WishlistView(@cubeId)
    
    @searchArchetypes = new CubeBuilder.SearchArchetypes(@cubeId, @cubeView)    
    @searchArchetypes.load =>
      @archetypesBadges = new CubeBuilder.ArchetypesBadges(@cubeId, @searchArchetypes, @cubeView)
      @searchArchetypes.archetypesBadges = @archetypesBadges
      @archetypesBadges.renderCubeBadges()      

      @cardShow = new CubeBuilder.CardShow(@archetypesBadges, @searchArchetypes, @cubeView, @cubeId, @wishlistView)
      @searchCard = new CubeBuilder.SearchCard(@archetypesBadges, @cardShow)
      
      @wishlistView.addClassInWishlist(@wishlistView.wishlist_ids)
      @archetypesView = new CubeBuilder.ArchetypesView(@archetypesBadges)
    
$().ready ->
  cubeId = parseInt($("#cubeId").html())
  cubeBuilder = new CubeBuilderApp(cubeId)