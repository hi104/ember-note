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
    setupController:(controller, model)->
        @._super.apply(@, arguments)
        controller.setNewModel()

    deactivate:->
        model = @controller.get('model')
        return if model.get('id')
        if (not model.get('isSaving') and not model.get('isDeleted'))
            model.deleteRecord()

)
