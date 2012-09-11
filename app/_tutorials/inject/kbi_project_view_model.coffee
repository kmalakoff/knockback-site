ProjectViewModel = kb.ViewModel.extend({
  constructor: (project, projects) ->
    kb.ViewModel.prototype.constructor.call(@, project, {requires: ['id', 'name', 'site', 'description']})

    @isClean = => not project.hasChanged()
    @onDelete = => # destroy() is reserved for ViewModel lifecycle
      project.destroy() unless project.isNew()
      loadUrl('')
      return false
    @save = =>
      projects.add(project) if project.isNew()
      project.save()
      loadUrl('')
      return false
    @
})