class CubeBuilder.ArchetypesView
  
  constructor: (@archetypesBadges) ->
    self = this
    $('#archetypes').on 'click', 'a.list-archetype', (e) -> self.showArchetype(e)
  
  showArchetype: (e) ->    
    el = $(e.toElement)  
    archetypeId = parseInt(el.data('id'))
    listByCmc = {}
    listByType = { "Creatures" : [], "Spells" : [], "Lands" : [] }
    archetype = @archetypesBadges.cubeArchetypes().filter (archetype) -> archetype.id == archetypeId
    archetype[0].cards.forEach (card) ->
      cell = $("#cube a.show_card[data-id=#{card["id"]}]")
      cardName = cell.html()
      cmc = cell.next().html()
      type = cell.data("type")
      if cmc == undefined
        cmc = 0
        
      listByCmc[cmc] ||= []
      listByCmc[cmc].push(cardName)
      
      if ("Creature" in type)
        listByType["Creatures"].push(cardName)
      else if ("Land" in type)
        listByType["Lands"].push(cardName)
      else
        listByType["Spells"].push(cardName)
        
    text = HandlebarsTemplates['cube_builder/archetype_view'](
      archetype: el.html(), 
      cards_by_cmc: listByCmc, 
      cards_by_type: listByType
    )
    $('#dialog').html text
    $('#archetype_list').modal({}) 

