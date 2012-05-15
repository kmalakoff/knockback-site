LongDateLocalizer = kb.LocalizedObservable.extend({
  constructor: (value, options, view_model) ->
    kb.LocalizedObservable.prototype.constructor.apply(this, arguments)
    return kb.utils.wrappedObservable(@)

  read: (value) ->
    return Globalize.format(value, 'dd MMMM yyyy', kb.locale_manager.getLocale())

  write: (localized_string, value) ->
    new_value = Globalize.parseDate(localized_string, 'dd MMMM yyyy', kb.locale_manager.getLocale())

    # reset if invalid
    if not (new_value and _.isDate(new_value))
      return kb.utils.wrappedObservable(this).resetToCurrent()

    value.setTime(new_value.valueOf())
})