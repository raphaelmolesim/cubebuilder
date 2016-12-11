class CubeBuilderApp
    
  constructor: (@cubeId) ->
    console.log("Cube Builder construtor")
    @searchArchetypes = new CubeBuilder.SearchArchetypes(@cubeId)
    @searchArchetypes.load =>
      @archetypesBadges = new CubeBuilder.ArchetypesBadges(@cubeId, @searchArchetypes)
      @searchArchetypes.archetypesBadges = @archetypesBadges
      @archetypesBadges.renderCubeBadges()
      
      @searchCard = new CubeBuilder.SearchCard(@archetypesBadges)
      @cardShow = new CubeBuilder.CardShow(@archetypesBadges, @searchArchetypes)
      
    
$().ready ->
  cubeId = parseInt($("#cubeId").html())
  cubeBuilder = new CubeBuilderApp(cubeId)