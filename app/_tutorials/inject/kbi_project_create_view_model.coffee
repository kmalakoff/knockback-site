ProjectCreateViewModel = kb.ViewModel.extend({
  constructor: (projects) ->
    kb.ViewModel.prototype.constructor.call(@, model = new Backbone.Model())
    @save = => projects.add(model).save()
    @
})
