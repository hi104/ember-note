App.NotesRoute = Ember.Route.extend(
    model:->
        unless @get('controller')
            notes = @store.filter("note", (e)-> true)
        else
            notes = @get('controller').get('model')
        notes

    setupController:(controller, model, queryParams)->
        @._super.apply(@, arguments);
        controller.search(queryParams)
)

App.NotesNewRoute = Ember.Route.extend(
    model:->
        @store.createRecord('note', {
            name: "",
            content: ""
        }).save()

    setupController:(controller, model)->
        @._super.apply(@, arguments)
        controller.transitionToRoute('note.edit', model.get('id'))
)
