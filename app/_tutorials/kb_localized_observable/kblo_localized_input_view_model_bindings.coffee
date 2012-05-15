model = new Backbone.Model({date: new Date()})

view_model =
  date: kb.observable(model, {key: 'date', localizer: LongDateLocalizer})
  toggleLocale: ->
    if (kb.locale_manager.getLocale() == 'en-GB')
      kb.locale_manager.setLocale('fr-FR')
    else
      kb.locale_manager.setLocale('en-GB')

ko.applyBindings(view_model, $('#kblo_read_write')[0])