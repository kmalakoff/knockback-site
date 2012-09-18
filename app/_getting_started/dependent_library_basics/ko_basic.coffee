model = {first_name: "Planet", last_name: "Earth"}

ViewModel = (model) ->
  @first_name = ko.observable(model.first_name)
  @last_name = ko.observable(model.last_name)
  @full_name = ko.computed((->return "#{@first_name()} #{@last_name()}"), @)
  return
view_model = new ViewModel(model)

ko.applyBindings(view_model, $('#ko_basic')[0])