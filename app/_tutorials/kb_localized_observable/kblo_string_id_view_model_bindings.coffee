texts = new Backbone.Model({main_text_id: 'body'})

view_model =
  main_text: kb.observable(texts, {key: 'main_text_id', localizer: LocalizedStringLocalizer})
  toggleLocale: ->
    if (kb.locale_manager.getLocale() == 'en-GB')
      kb.locale_manager.setLocale('fr-FR')
    else
      kb.locale_manager.setLocale('en-GB')

ko.applyBindings(view_model, $('#kblo_read_only')[0])