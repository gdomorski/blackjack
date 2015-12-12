class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()
    @busted()
      #if @scores()[1] > @scores()[0] && @scores()[1] <= 21
      # @set 'scores', [@scores()[1], @scores()[1]]
        #@scores = [@scores()[1], @scores()[1]]


  stand: =>
    if @isDealer
      @models[0].flip()
      while @scores()[0] < 17
        @hit()

    console.log(@)
    # if @scores()[1] > @scores()[0] && @scores()[1] <= 21
    #   @set 'scores', [@scores()[1], @scores()[1]]
      # @scores = [@scores()[1], @scores()[1]]

    @trigger('endGame')


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
    if (@minScore() > (@minScore() + 10 * @hasAce()))
      [@minScore(), @minScore() + 10 * @hasAce()]
    else
      [@minScore() + 10 * @hasAce(), @minScore()]

  busted: -> 
    totalScore1 = @scores()[0]
    totalScore2 = @scores()[1]
    if (totalScore1 > 21 && totalScore2 > 21) then alert 'The score is over 21! Bust!'