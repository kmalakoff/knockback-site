ProjectAppController = (view_model, element) ->
  knockback_model = {id: 'id_kb', name: 'Knockback.js', description: 'Backbone.js + Knockout.js is amazingly!', site: 'http://kmalakoff.github.com/knockback/'}
  projects = new Backbone.Collection([knockback_model])
  projects.url = 'https://api.mongolab.com/api/1/databases/angularjs/collections/projects?apiKey=4f847ad3e4b08a2eed5f3b54'
  projects.parse = (data) -> return _.map(data, (item) -> item.id = item._id.$oid; return item) # remap the ids
  projects.fetch()

  active_el = null
  loadPage = (el) ->
    ko.removeNode(active_el) if active_el
    element.appendChild(active_el = el)

  router = new Backbone.Router()
  router.route('', null, ->
    loadPage(kb.renderTemplate('list.html', new ProjectListViewModel(projects)))
  )
  router.route('new', null, ->
    loadPage(kb.renderTemplate('detail.html', new ProjectCreateViewModel(projects)))
  )
  router.route('edit/:projectId', null, (project_id) ->
    (window.location.hash = ''; return) unless project = projects.get(project_id) # not a valid project
    loadPage(kb.renderTemplate('detail.html', new ProjectDetailViewModel(project)))
  )
  @

# start outside of the binding loop
projectAppStartRouting = ->
  Backbone.history.start({hashChange: true}) unless Backbone.History.started