class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'
  
  template2: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png"</img>'

  template3: _.template '<img src="img/card-back.png"</img>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @$el.hasClass 'covered'
      @$el.html @template3 @model.attributes
    else
      @$el.html @template2 @model.attributes
