class CubeBuilder.WishlistView
  
  constructor: (@cubeId) ->
    @wishlist_ids = []
    self = this
    self.loadWishlist () ->
    $("#show_wishlist").click -> self.showWishlist()      
  
  loadWishlist: (callback) ->
    $.ajax
      method: 'GET'
      url: "/cubes/#{@cubeId}/wishlist",
      dataType: 'json'
     .done (response )=>
       @wishlist_ids = response
       callback(@wishlist_ids)
  
  addClassInWishlist: (wishlist_ids) ->
    wishlist_ids.forEach (id) ->
      cell = $("a.show_card[data-id=#{id}]")
      cell.addClass("wishlist")
      
  showWishlist: (e) ->
    wishlist = []
    @wishlist_ids.forEach (id) ->
      cell = $("a.show_card[data-id=#{id}]")
      card_name = cell.html()
      wishlist.push(card_name)
    text = HandlebarsTemplates['cube_builder/wishlist_view']({ wishlist:  wishlist})
    $('#dialog').html text
    $('#wishlist').modal({})