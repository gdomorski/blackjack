class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="dd-button">Double Down</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset Game</button> 
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  # template2: _.template '<img class="moveRight" src="img/blackjackstrategy.jpg"</img>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .reset-button': -> location.reload()
    'click .dd-button': -> @model.get('playerHand').doubleDown()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      @model.get('dealerHand').stand()
    
    
  initialize: ->
    @model.get('dealerHand').on('endGame', @gameEnd)
    @render() 

  render: ->
    @$el.children().detach()
    @$el.addClass 'gameView'
    @$el.html @template()
    # @$el.append @template2()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  gameEnd: =>
    if @model.get('dealerHand').scores()[0] > 21
      alert('Dealer Busted. You win')
    else if @model.get('dealerHand').scores()[0] > @model.get('playerHand').scores()[0]
      alert 'Dealer wins...'
    else if @model.get('dealerHand').scores()[0] == @model.get('playerHand').scores()[0]    
      alert 'Tie Game'
    else
      alert 'YOU WIN'
