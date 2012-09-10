ProjectCreateViewModel = kb.ViewModel.extend({
  constructor: (projects) ->
    model = new Backbone.Model()
    kb.ViewModel.prototype.constructor.call(@, model, {requires: ['name', 'site', 'description']})

    @save = => projects.add(model).save()
    @
})
