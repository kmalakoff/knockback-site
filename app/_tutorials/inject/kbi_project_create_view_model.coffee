ProjectCreateViewModel = kb.ViewModel.extend({
  constructor: (projects) ->
    model = new Backbone.Model()
    kb.ViewModel.prototype.constructor.call(@, model, {requires: ['name', 'site', 'description']})

    @delete = => # destroy is reserved for ViewModel lifecycle
      window.location.hash = ''
    @save = =>
      projects.add(model)
      model.save()
      window.location.hash = ''
    @
})
