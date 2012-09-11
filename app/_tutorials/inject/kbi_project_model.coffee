PROJECTS_BASE_URL = 'https://api.mongolab.com/api/1/databases/angularjs/collections/projects'
PROJECTS_API_KEY_PARAM = 'apiKey=4f847ad3e4b08a2eed5f3b54'

Project = Backbone.Model.extend({
  url: -> "#{PROJECTS_BASE_URL}/#{@id}?#{PROJECTS_API_KEY_PARAM}"
})
