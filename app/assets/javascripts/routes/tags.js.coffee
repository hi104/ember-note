App.TagsRoute = Ember.Route.extend(
    model:(params) ->
        @store.find('tag') # for load from server
)

App.TagsIndexRoute = Ember.Route.extend(
    model: ->
        @store.all('tag')
)

App.TagRoute = Ember.Route.extend(
    model:(params)->
        @store.getById('tag', params.tag_id)
)

App.TagEditRoute = Ember.Route.extend(
    setupController:(controller, model)->
        @._super.apply(@, arguments)
        @controller.set('model', @controllerFor('tag').get('model'))

    deactivate: ->
        @controller.get('model').cancelEdit()

)
