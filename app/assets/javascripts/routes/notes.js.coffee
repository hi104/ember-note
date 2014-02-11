App.NotesRoute = Ember.Route.extend(
    model:->
        unless @get('controller')
            notes = @store.filter("note", (e)-> true)
        else
            notes = @get('controller').get('model')
        notes

    setupController:(controller, model, queryParams)->
        @._super.apply(@, arguments);
        if not controller.get('sortProperty')
            controller.set('sortProperty', App.noteSortPropetyies[0])
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

    deactivate:->
        model = @controller.get('model')
        return if model.get('id')
        if (not model.get('isSaving') and not model.get('isDeleted'))
            model.deleteRecord()

)
