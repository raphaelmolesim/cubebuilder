class CubeBuilder.CubeFilter
  
  constructor: (@cubeId, @cubeView) ->
    $("#apply-filter").click (e) => this.filter(e)
  
  filter: (e) ->
    e.preventDefault()
    $el = $(e.target)
    numPlayers = $("#qtd-players").val()
    @cubeView.render(numPlayers)
    
  