bulk_locale_manager = new LocaleManager('en', {
  'en':
    name: 'Name: '
    start_date: 'Start Date: '
    end_date: 'End Date: '
  'fr':
    name: 'Nom: '
    start_date: 'Commencement: '
    end_date: 'Clôture: '
})

view_model = kb.viewModel(new Backbone.Model({name: 'Bob', start_date: '1/1/2012', end_date: '1/2/2012'}))

# use ko.observable to create multiple labels quickly
view_model.labels = kb.viewModel(bulk_locale_manager, ['name', 'start_date', 'end_date'])
view_model.toggleLocale = ->
  bulk_locale_manager.setLocale(if (bulk_locale_manager.getLocale() is 'en') then 'fr' else 'en')

ko.applyBindings(view_model, $('#lm_bulk_labels')[0])