class Router extends Backbone.Router
  routes:
    "decks":          "home"
    "decks/new":      "deckNew"
    "decks/:id/edit": "deckEdit"

  home: ->
    @initializeAppView() unless @appView
    @appView.showDeckIndex()
    @appView.collection.fetch()

  deckNew: ->
    @initializeAppView() unless @appView
    @appView.showDeckNew()

  deckEdit: (id) ->
    @initializeAppView() unless @appView
    @appView.showDeckEdit(id)

  initializeAppView: ->
    @appView = new DeckApp.AppView
      preloadData: DeckApp.preloadData
      collection: DeckApp.Decks

@DeckApp = window.DeckApp || {}
@DeckApp.Router = Router
