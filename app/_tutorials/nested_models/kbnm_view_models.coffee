bob = new Backbone.Model({name: "Bob"})
fred = new Backbone.Model({name: "Fred", friends: new Backbone.Collection([bob])})
bob.set({friends: new Backbone.Collection([fred])})

FriendViewModel = (model, options) ->
  @type = 'friend'
  @name = kb.observable(model, 'name')
  @friends = kb.collectionObservable(model.get('friends'), kb.utils.optionsPathJoin(options, 'friends'))
  return

class PersonViewModel extends kb.ViewModel
  constructor: (model, options) ->
    @type = 'person'
    super

view_model = new PersonViewModel(fred, {
  factories:
    'friends.models': FriendViewModel
    'friends.models.friends.models': FriendViewModel
})

ko.applyBindings(view_model, $('#kbnm_view_models')[0])