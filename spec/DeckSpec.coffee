assert = chai.assert


describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    # playSpy = sinon.spy(Hand.prototype, 'busted')
    # console.log(playSpy)
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual hand.hit()
      assert.strictEqual deck.length, 49


  describe 'doubleDown', ->
    it 'should display two cards', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual hand.doubleDown()
      assert.strictEqual deck.length, 48


  describe 'stand', ->
    it 'should make the dealer draw cards', -> 
      hand = deck.dealDealer()
      assert.strictEqual hand.isDealer, true
      hand.stand()
      hand.stand().trigger('ended')


  describe 'bust', ->
    hand.busted().trigger('bust')


  # describe 'should show the closest score to 21 if the player has an Ace', ->



      # previousSize = deck.length
      # hand.stand()
      # assert.strictEqual deck.length, 50 - 


