# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.

#class window.App = new Game()

class window.App extends Backbone.Model
    initialize: -> 
      @set 'deck', deck = new Deck()
      @set 'playerHand', deck.dealPlayer()
      @set 'dealerHand', deck.dealDealer()
      $('body').append('<div><img class="moveRight" src="img/blackjackstrategy.jpg"></img></div>')
