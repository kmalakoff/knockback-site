ProjectViewModel = kb.ViewModel.extend({
  constructor: (project, projects) ->
    kb.ViewModel.prototype.constructor.call(@, project, {requires: ['id', 'name', 'site', 'description']})

    start_attributes = _.clone(project.attributes)
    @model_changed = kb.triggeredObservable(project, 'change')
    @isClean = ko.computed(=>
      @model_changed() # create a depdendency
      return _.isEqual(start_attributes, project.attributes)
    )
    @onDelete = -> # destroy() is reserved for ViewModel lifecycle
      project.destroy() unless project.isNew()
      loadUrl('')
      return false
    @save = ->
      projects.add(project) if project.isNew()
      project.save()
      loadUrl('')
      return false
    @
})