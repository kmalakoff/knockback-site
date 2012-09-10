ProjectAppController = (view_model, element) ->
  projects = new Backbone.Collection()
  projects.url = 'https://api.mongolab.com/api/1/databases/angularjs/collections/projects?apiKey=4f847ad3e4b08a2eed5f3b54'
  projects.parse = (data) -> return _.map(data, (item) -> item.id = item._id.$oid; return item) # remap the ids
  projects.fetch()

  #REMOVE
  window.projects = projects

  router = new Backbone.Router()
  active_el = null
  router.route('', null, ->
    ko.removeNode(active_el) if active_el
    active_el = kb.renderAutoReleasedTemplate('list.html', {projects: kb.collectionObservable(projects, {sort_attribute: 'name'})})
    element.appendChild(active_el)
  )
  router.route('new', null, ->
    ko.removeNode(active_el) if active_el
    active_el = kb.renderAutoReleasedTemplate('detail.html', new ProjectCreateViewModel(projects))
    element.appendChild(active_el)
  )
  router.route('edit/:projectId', null, (project_id) ->
    (window.location.hash = ''; return) unless project = projects.get(project_id) # not a valid project
    ko.removeNode(active_el) if active_el
    active_el = kb.renderAutoReleasedTemplate('detail.html', new ProjectDetailViewModel(project))
    element.appendChild(active_el)
  )
  window.location.hash = ''
  Backbone.history.start({hashChange: true}) unless Backbone.History.started
  @