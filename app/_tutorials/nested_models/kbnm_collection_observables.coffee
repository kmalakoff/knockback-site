bob = new Backbone.Model({name: "Bob", friends: new Backbone.Collection()})
fred = new Backbone.Model({name: "Fred", friends: new Backbone.Collection([bob])})

FriendViewModel = (model) ->
  @name = kb.observable(model, 'name')
  @type = ko.observable('friend')
  return

class PersonViewModel extends kb.ViewModel
  constructor: (model, options) ->
    super
    @type = ko.observable('person')

view_model = {
  people: kb.collectionObservable(new Backbone.Collection([bob, fred]), {
    factories:
      'models': PersonViewModel
      'models.friends.models': FriendViewModel
  })
}

ko.applyBindings(view_model, $('#kbnm_collection_observables')[0])