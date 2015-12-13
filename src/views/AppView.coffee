class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="dd-button">Double Down</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset Game</button> 
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="cardCount"></div>
  '

  # template2: _.template '<img class="moveRight" src="img/blackjackstrategy.jpg"</img>'

  currentCount: 0

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      @cardCount()
      @render()
    'click .reset-button': -> location.reload()
    'click .dd-button': -> @model.get('playerHand').doubleDown()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      @model.get('dealerHand').stand()
    
  initialize: ->
    @model.get('dealerHand').on('endGame', @gameEnd)
    @cardCount()
    @render() 

  render: ->
    @$el.children().detach()
    @$el.addClass 'gameView'
    @$el.html @template()
    # @$el.append @template2()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.cardCount').html('The current count is ' + @currentCount)

  cardCount: =>
    @currentCount = 0;
    console.log(@model.get('playerHand').models)
    for playerCount in @model.get('playerHand').models
      if playerCount.attributes.rankName == 'ace'
        @currentCount--
      else if playerCount.attributes.value <= 6
        @currentCount++
      else if playerCount.attributes.value > 9
        @currentCount--

    for dealerCount in @model.get('dealerHand').models
      if dealerCount.attributes.revealed != false
        if dealerCount.attributes.rankName == 'ace'
          @currentCount--
        else if dealerCount.attributes.value <= 6
          @currentCount++
        else if dealerCount.attributes.value > 9
          @currentCount--
      

  gameEnd: =>
    if @model.get('dealerHand').scores()[0] > 21
      alert('Dealer Busted. You win')
    else if @model.get('dealerHand').scores()[0] > @model.get('playerHand').scores()[0]
      alert 'Dealer wins...'
    else if @model.get('dealerHand').scores()[0] == @model.get('playerHand').scores()[0]    
      alert 'Tie Game'
    else
      alert 'YOU WIN'
