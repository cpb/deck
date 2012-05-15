class DeckIndexView extends Backbone.View
  class: 'deck-index-wrap'

  template: _.template($('#deck-index-template').html())

  initialize: ->
    @collection.on 'reset', @render, this

  render: ->
    @$el.html(@template(number_of_decks: @collection.length))
    @deckListContainer = @$el.find('.deck-list')

    _.each(@collection.models, (deck) =>
      iconView = new DeckApp.DeckIconView(model: deck)
      @deckListContainer.append(iconView.render())
    )

@DeckApp = window.DeckApp || {}
@DeckApp.DeckIndexView = DeckIndexView
