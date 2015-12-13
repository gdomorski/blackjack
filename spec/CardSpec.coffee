assert = chai.assert

describe "deck constructor", ->

  beforeEach ->
    collection = new Deck()


  it "should create a card collection", ->
    assert.strictEqual collection.length, 52
