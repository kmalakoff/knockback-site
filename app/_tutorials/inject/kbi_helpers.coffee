ko.bindingHandlers['classes'] =
  update: (element, value_accessor) ->
    for key, state of ko.utils.unwrapObservable(value_accessor())
      if state then $(element).addClass(key) else $(element).removeClass(key)
    @