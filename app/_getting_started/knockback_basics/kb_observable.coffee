model = new Backbone.Model({first_name: "Planet", last_name: "Earth"})

ViewModel = (model) ->
  @first_name = kb.observable(model, 'first_name')
  @last_name = kb.observable(model, 'last_name')
  @full_name = ko.computed((->return "#{this.first_name()} #{this.last_name()}"), @)
  return

view_model = new ViewModel(model)

ko.applyBindings(view_model, $('#kb_observable')[0])