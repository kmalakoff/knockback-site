ProjectListViewModel = (projects) ->
  @filter = ko.observable('')
  @projects = kb.collectionObservable(projects, {
    view_model: ProjectDetailViewModel
    sort_attribute: 'name'
    filters: (model) =>
      filter = @filter()
      return false unless filter
      return (model.get('name').search(filter) < 0)
  })
  @