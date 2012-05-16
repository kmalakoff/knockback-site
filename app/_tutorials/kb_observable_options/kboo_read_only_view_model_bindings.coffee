model = new Backbone.Model({number: 33})

ViewModel = (model) ->
  @number = kb.observable(model, {
    key: 'number',
    read_only: true
  })
  @number_wrapper = ko.computed({
    read: @number
    write: (value) ->
      try
        @number(value)
      catch e
        alert("#{e}. Model value: #{model.get('number')}")
    owner: @
  })
  @

view_model = new ViewModel(model)

ko.applyBindings(view_model, $('#kboo_read_only')[0])