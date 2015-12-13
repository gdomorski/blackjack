class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()
    @busted()

  doubleDown: ->
    @hit()
    @hit()


  stand: =>
    if @isDealer
      @models[0].flip()
      while @scores()[0] < 17
        @hit()
    @trigger('endGame')

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) =>
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    if ((@minScore() + 10 * @hasAce()) > @minScore() && (@minScore() + 10 * @hasAce()) <= 21)
      [@minScore() + 10 * @hasAce(), @minScore()]
    else
      [@minScore(), @minScore() + 10 * @hasAce()]

  busted: -> 
    totalScore1 = @scores()[0]
    totalScore2 = @scores()[1]
    if (totalScore1 > 21 && totalScore2 > 21) then alert 'The score is over 21! Bust!'
    @trigger('bust')