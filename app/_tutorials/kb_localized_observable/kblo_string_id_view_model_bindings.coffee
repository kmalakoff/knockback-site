texts = new Backbone.Model({main_text_id: 'body'})

view_model =
  main_text: kb.observable(texts, {key: 'main_text_id', localizer: LocalizedStringLocalizer})
  toggleLocale: ->
    kb.locale_manager.setLocale(if kb.locale_manager.getLocale() is 'en-GB' then 'fr-FR' else 'en-GB')

ko.applyBindings(view_model, $('#kblo_read_only')[0])