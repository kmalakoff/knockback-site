window.kb or= {}
kb.docs or = {}
kb.docs.kb_observables or = {}

kb.docs.kb_observables =
  overview: ->
    ContactViewModel = (model) ->
      @attribute_observables = kb.observables(model, {
        name:     {key: 'name', read_only: true}
        number:   'number'
        date:     {key:'date', localizer: LongDateLocalizer}
        name2:    {key: 'name', read_only: true}
      }, this)
      @

    model = new Contact({name: 'John', number: '555-555-5558', date: new Date(1940, 10, 9)})
    view_model = new ContactViewModel(model)

  kb_observables: ->
    view_model = {}
    kb.observables(model, {name: 'name', date: 'date'}, view_model)

  constructor: ->
    view_model = {}
    new kb.Observables(model, {name: 'name', date: 'date'}, view_model)

  setToDefault: ->
    ContactViewModel = (model) ->
      @loading_message = ko.observable('(none)')
      @attribute_observables = kb.observables(model, {
        name:     {key:'name', default: @loading_message}
        number:   {key:'number', default: @loading_message}
      }, this)
      @

    view_model = new ContactViewModel(new Backbone.Model({name: 'Bob'}))
    # name is Bob and number is (none)

    view_model.setToDefault()
    # name and number are (none)

    view_model.loading_message('(nada)')
    # name and number are (nada)