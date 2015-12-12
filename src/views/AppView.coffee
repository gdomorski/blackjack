class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .reset-button': -> location.reload()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      @model.get('dealerHand').stand()
    
    
  initialize: ->
    @model.get('dealerHand').on('endGame', @gameEnd)
    @render() 

  render: ->
    @$el.children().detach()
    @$el.html @template()
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
