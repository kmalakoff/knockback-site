ProjectDetailViewModel = kb.ViewModel.extend({
  constructor: (project) ->
    kb.ViewModel.prototype.constructor.call(@, project)

    @isClean = => not project.hasChanged()
    @destroy = =>
      project.destroy()
      window.location.hash = ''
    @save = =>
      project.save()
      window.location.hash = ''
    @
})
