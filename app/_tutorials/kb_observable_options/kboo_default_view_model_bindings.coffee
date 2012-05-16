model = new Backbone.Model({})

ViewModel = (model) ->
  @name = kb.observable(model, {
    key: 'name'
    default: '(no name)'
  })
  @

view_model = new ViewModel(model)

ko.applyBindings(view_model, $('#kboo_default')[0])