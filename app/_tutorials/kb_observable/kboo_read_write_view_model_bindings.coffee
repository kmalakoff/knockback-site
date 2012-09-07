model = new Backbone.Model({number: 33})

ViewModel = (model) ->
  @number = kb.observable(model, 'number')
  @formatted_number = kb.observable(model, {
    key:'number'
    read: -> return "#: #{@number()}"
    write: (value) -> @number(value.substring(3))
  }, @)
  @

view_model = new ViewModel(model)

ko.applyBindings(view_model, $('#kboo_read_write')[0])