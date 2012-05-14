class LocaleManager
  constructor: (locale_identifier, @translations_by_locale) ->
    @current_locale = ko.observable(locale_identifier)

  get: (string_id) ->
    return '(no translation)' unless @translations_by_locale[@current_locale()]
    return '(no translation)' unless @translations_by_locale[@current_locale()].hasOwnProperty(string_id)
    return @translations_by_locale[@current_locale()][string_id]

  getLocale: -> return @current_locale()
  setLocale: (locale_identifier) ->
    @current_locale(locale_identifier)
    @trigger('change', @)

_.extend(LocaleManager.prototype, Backbone.Events)