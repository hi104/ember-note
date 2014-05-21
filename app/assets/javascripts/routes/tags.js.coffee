App.TagsIndexRoute = Ember.Route.extend(
    model:(params) ->
        @store.find('tag')

    setupController:(controller, model, queryParams)->
        @._super.apply(@, arguments);
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
