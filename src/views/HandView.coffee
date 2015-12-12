class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    console.log @collection
    @render()
    # @collection.on 'change', => @checkScore
    @collection.on 'bust', => @busted(-> alert('Hey'))

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  # busted: (f) -> 
  #   ->
  #     f?.apply this, arguments
  #     f = null
  checkScore: ->
    if @collection.minScore > 21 then console.log 'BUST'