ProjectDetailViewModel = kb.ViewModel.extend({
  constructor: (project) ->
    kb.ViewModel.prototype.constructor.call(@, project, {requires: ['name', 'site', 'description']})

    @isClean = => not project.hasChanged()
    @delete = => # destroy is reserved for ViewModel lifecycle
      project.destroy()
      window.location.hash = ''
    @save = =>
      project.save()
      window.location.hash = ''
    @
})
