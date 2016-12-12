class CubeBuilderApp
    
  constructor: (@cubeId) ->
    console.log("Cube Builder construtor")
    
    @cubeView = new CubeBuilder.CubeView(@cubeId)
    @cubeView.render()
    
    @searchArchetypes = new CubeBuilder.SearchArchetypes(@cubeId)    
    @searchArchetypes.load =>
      @archetypesBadges = new CubeBuilder.ArchetypesBadges(@cubeId, @searchArchetypes)
      @searchArchetypes.archetypesBadges = @archetypesBadges
      @archetypesBadges.renderCubeBadges()
      

      @cardShow = new CubeBuilder.CardShow(@archetypesBadges, @searchArchetypes, @cubeView)
      @searchCard = new CubeBuilder.SearchCard(@archetypesBadges, @cardShow)
      
      
    
$().ready ->
  cubeId = parseInt($("#cubeId").html())
  cubeBuilder = new CubeBuilderApp(cubeId)