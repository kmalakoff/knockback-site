LocalizedStringLocalizer = kb.LocalizedObservable.extend({
  constructor: (value, options, view_model) ->
    kb.LocalizedObservable.prototype.constructor.apply(this, arguments)
    return kb.utils.wrappedObservable(@)

  read: (string_id) ->
    return if (string_id) then kb.locale_manager.get(string_id) else ''
})