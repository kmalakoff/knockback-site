ProjectAppController = (view_model, element) ->
  knockback_model = {id: 'id_kb', name: 'Knockback.js', description: 'Backbone.js + Knockout.js is amazingly!', site: 'http://kmalakoff.github.com/knockback/'}
  projects = new ProjectCollection([knockback_model])
  projects.fetch()

  active_el = null
  loadPage = (el) ->
    ko.removeNode(active_el) if active_el
    element.appendChild(active_el = el)

  router = new Backbone.Router()
  router.route('*path', null, -> _.defer(loadUrlFn('')))
  router.route('', null, ->
    loadPage(kb.renderTemplate('list.html', new ProjectListViewModel(projects)))
  )
  router.route('new', null, ->
    loadPage(kb.renderTemplate('detail.html', new ProjectViewModel(new Project(), projects)))
  )
  router.route('edit/:projectId', null, (project_id) ->
    (loadUrl(''); return) unless project = projects.get(project_id) # not a valid project
    loadPage(kb.renderTemplate('detail.html', new ProjectViewModel(project)))
  )
  @

# start outside of the binding loop
projectAppStartRouting = ->
  Backbone.history.start({pushState: true, root: window.location.pathname}) unless Backbone.History.started