# create and initialize the locale manager with two languages
simple_locale_manager = new LocaleManager('en', {
  'en':
    name: 'Name: '
  'fr':
    name: 'Nom: '
})

bob = new Backbone.Model({name: 'Bob'})

view_model = kb.viewModel(bob)

# add a localized label for 'name' and a function for toggling the current locale
view_model.label_name = kb.observable(simple_locale_manager, 'name')
view_model.toggleLocale = ->
  if (simple_locale_manager.getLocale() == 'en')
    simple_locale_manager.setLocale('fr')
  else
    simple_locale_manager.setLocale('en')

ko.applyBindings(view_model, $('#lm_simple')[0])