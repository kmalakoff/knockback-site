ProjectAppController = (view_model) ->
  projects = new Backbone.Collection()
  projects.url = 'https://api.mongolab.com/api/1/databases/angularjs/collections/projects?apiKey=4f847ad3e4b08a2eed5f3b54'
  projects.parse = (data) -> return _.map(data, (item) -> item.id = item._id.$oid; return item) # remap the ids
  projects.fetch()

  #REMOVE
  window.projects = projects

  view_model.loaded = (page_navigator) ->
    router = new Backbone.Router()
    router.route('', null, page_navigator.dispatcher(->
      page_navigator.loadPage(
        kb.renderAutoReleasedTemplate('list.html', {projects: kb.collectionObservable(projects, {sort_attribute: 'name'})})
      )
    ))
    router.route('new', null, page_navigator.dispatcher(->
      page_navigator.loadPage(
        kb.renderAutoReleasedTemplate('detail.html', new ProjectCreateViewModel(projects))
      )
    ))
    router.route('edit/:projectId', null, page_navigator.dispatcher((projectId)->
      page_navigator.loadPage(
        kb.renderAutoReleasedTemplate('detail.html', new ProjectEditViewModel(projects, project_id))
      )
    ))
    Backbone.history.start({hashChange: true})
  @