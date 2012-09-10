ProjectDetailViewModel = (projects, project_id) ->
  project = projects.get(project_id)
  @isClean = => not project.hasChanged()

  @destroy = =>
    project.destroy()
    window.location.hash = ''

  @save = =>
    project.save()
    window.location.hash = ''

  @