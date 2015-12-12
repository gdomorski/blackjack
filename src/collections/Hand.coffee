class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()
    @busted()


  stand: =>
    playerScore = @scores()[0]

    console.log(@isDealer)
    if @isDealer
      console.log(@)
      @models[0].flip()
      while @scores()[0] < 17
        @hit()

    @trigger('endGame')

    #check the deals score
    #while he is under 17
    # hit the dealer
    
    #compare the scores
    #return the winner


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) =>
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  busted: -> 
    totalScores = @scores()[0]
    if totalScores > 21 then alert 'You Suck'