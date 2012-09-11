ProjectCollection = Backbone.Collection.extend({
  url: "#{PROJECTS_BASE_URL}?#{PROJECTS_API_KEY_PARAM}"
  parse: (data) -> return _.map(data, (item) -> item.id = item._id.$oid; return item) # remap the ids
  model: Project
})