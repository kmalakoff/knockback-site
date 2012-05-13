earth = new Backbone.Model({first_name: 'Planet', last_name: 'Earth'})
mars = new Backbone.Model({first_name: 'Planet', last_name: 'Mars'})

planets = new Backbone.Collection([earth, mars])

view_model =
  planets: kb.collectionObservable(planets, {view_model: kb.ViewModel})

ko.applyBindings(view_model, $('#kb_collection')[0])