bob = new Backbone.Model({name: "Bob"})
fred = new Backbone.Model({name: "Fred", friends: new Backbone.Collection([bob])})
bob.set({friends: new Backbone.Collection([fred])})

FriendViewModel = (model, options) ->
  @name = kb.observable(model, 'name')
  @type = ko.observable('friend')
  @friends = kb.collectionObservable(model.get('friends'), kb.utils.optionsPathJoin(options, 'friends'))
  @

class PersonViewModel extends kb.ViewModel
  constructor: (model, options) ->
    super
    @type = ko.observable('person')

view_model = new PersonViewModel(fred, {
  mappings:
    'friends.models': FriendViewModel
    'friends.models.friends.models': FriendViewModel
})

ko.applyBindings(view_model, $('#kbnm_view_models')[0])