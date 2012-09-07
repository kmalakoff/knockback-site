model = new Backbone.Model({first_name: "Planet", last_name: "Earth"})

class MyViewModel extends kb.ViewModel
  constructor: (model) ->
    super
    @full_name = ko.computed((->return "#{@first_name()} #{@last_name()}"), @)
view_model = new MyViewModel(model)

ko.applyBindings(view_model, $('#kb_view_model_inheritance')[0])