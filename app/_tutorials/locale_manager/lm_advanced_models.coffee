class LocaleManager
  constructor: (locale_identifier, @translations_by_locale) ->
    @current_locale = ko.observable()
    @setLocale(locale_identifier)

  get: (string_id) ->
    return '(no translation)' unless @translations_by_locale[@current_locale()]
    return '(no translation)' unless @translations_by_locale[@current_locale()].hasOwnProperty(string_id)

    string = @translations_by_locale[@current_locale()][string_id]
    return string if arguments == 1     # no arguments

    # add arguments
    string = string.replace("{#{index}}", arg) for arg, index in Array.prototype.slice.call(arguments, 1)
    return string

  getLocale: -> return @current_locale()
  setLocale: (locale_identifier) ->
    @current_locale(locale_identifier)
    @trigger('change', @)
    @trigger("change:#{key}", value) for key, value of @translations_by_locale[@current_locale()]

  getLocales: ->
    locales = []
    locales.push(string_id) for string_id, value of @translations_by_locale
    return locales

_.extend(LocaleManager.prototype, Backbone.Events)