# helper to toggle classes
ko.bindingHandlers['classes'] =
  update: (element, value_accessor) ->
    for key, state of ko.utils.unwrapObservable(value_accessor())
      if state then $(element).addClass(key) else $(element).removeClass(key)
    @

# helpers to manage push state
window.loadUrl = (url) ->
  Backbone.history.loadUrl(url)
window.loadUrlFn = (url) ->
  return ->
    Backbone.history.loadUrl(url)