people = new Backbone.Collection([{first: 'Jeremy', last: 'Ashkenas'}, {first: 'Steven', last: 'Sanderson'}, {first: 'Kevin', last: 'Malakoff'}])
filtered_names = ko.observableArray(['Kevin'])

view_model =
  filtered_names: filtered_names
  available_names: ko.observableArray(people.map((model) -> return model.get('first')))
  people: kb.collectionObservable(people, {filters: (model) -> return model.get('first') is filtered_names()[0]})

ko.applyBindings(view_model, $('#kbco_filtering')[0])