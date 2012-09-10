TodoCtrl = (view_model) ->
  view_model.todos = ko.observableArray([
    {text:'learn knockback', done:ko.observable(true)},
    {text:'build a knockback app', done:ko.observable(false)}]
  )

  view_model.todoText = ko.observable('')
  view_model.addTodo = ->
    view_model.todos.push({text:view_model.todoText(), done:ko.observable(false)})
    view_model.todoText('')

  view_model.remaining = ko.computed(->
    return _.reduce(view_model.todos(), ((count, todo) -> return count + (if todo.done() then 0 else 1)), 0)
  )

  view_model.archive = ->
    view_model.todos.remove((todo) -> return todo.done())

ko.bindingHandlers['classes'] =
  update: (element, value_accessor) ->
    for key, state of ko.utils.unwrapObservable(value_accessor())
      if state then $(element).addClass(key) else $(element).removeClass(key)
    @