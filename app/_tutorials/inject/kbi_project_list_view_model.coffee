ProjectListViewModel = (projects) ->
  @filter = ko.observable('')
  @projects = kb.collectionObservable(projects, {
    view_model: ProjectViewModel
    sort_attribute: 'name'
    filters: [(model) =>
      return true unless filter = @filter()
      return model.get('name') and ((model.get('name').search(filter) >= 0))
    ]
  })
  return