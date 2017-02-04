var ko = kb.ko;

var TodoCtrl = function(view_model) {
  view_model.todos = ko.observableArray([
    {text: 'learn knockback', done: ko.observable(true)},
    {text: 'build a knockback app', done: ko.observable(false)}
  ]);

  view_model.todoText = ko.observable('');
  view_model.addTodo = function() {
    view_model.todos.push({text: view_model.todoText(), done: ko.observable(false)});
    view_model.todoText('');
  };

  view_model.remaining = ko.computed(function() {
    return _.reduce(view_model.todos(), (function(count, todo) {return count + (todo.done() ? 0 : 1);}), 0);
  });

  view_model.archive = function() {
    return view_model.todos.remove(function(todo) {return todo.done();});
  };
};