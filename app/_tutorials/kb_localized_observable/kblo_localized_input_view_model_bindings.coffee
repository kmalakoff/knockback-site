model = new Backbone.Model({date: new Date()})

view_model =
  date: kb.observable(model, {key: 'date', localizer: LongDateLocalizer})
  toggleLocale: ->
    kb.locale_manager.setLocale(if kb.locale_manager.getLocale() is 'en-GB' then 'fr-FR' else 'en-GB')

ko.applyBindings(view_model, $('#kblo_read_write')[0])