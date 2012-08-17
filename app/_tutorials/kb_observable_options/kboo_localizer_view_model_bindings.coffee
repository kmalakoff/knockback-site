model = new Backbone.Model({date: new Date()})

view_model =
  date: kb.observable(model, {key: 'date', localizer: LongDateLocalizer})