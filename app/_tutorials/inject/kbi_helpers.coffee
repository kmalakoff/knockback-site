# helper to toggle classes
ko.bindingHandlers['classes'] =
  update: (element, value_accessor) ->
    for key, state of ko.utils.unwrapObservable(value_accessor())
      $(element)[if ko.utils.unwrapObservable(state) then 'addClass' else 'removeClass'](key)
    return

# helpers to manage push state
window.loadUrl = (url) -> Backbone.history.loadUrl(url)
window.loadUrlFn = (url) -> return -> Backbone.history.loadUrl(url)