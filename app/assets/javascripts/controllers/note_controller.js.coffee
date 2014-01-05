App.NoteController = Em.ObjectController.extend
    deactivate: ->
        @get('controller').set('model', null)

App.NoteShowController = Em.ObjectController.extend
    needs:['notes']

    actions:
        delete:(note)->
            @get('controllers.notes').send('delete', note)

App.NoteEditController = Em.ObjectController.extend(
    back:->
        model = @get('model')
        @transitionToRoute('note.show', model.get('id'))
        $('#note-list').focus()

    actions:
        save:()->
            model = @get('model')
            model.save().then((data)=>
                model.cleanTaggings()
                Bootstrap.GNM.push('SUCCESS!', 'Save Success', 'success');
                @back()
            ,(result) =>
                if not (result instanceof DS.InvalidError)
                    Bootstrap.GNM.push('Error!',  + result.statusText, 'danger');
            )

        cancel:()->
            model = @get('model')
            if model.get('isDirty')
                model._inFlightAttributes = {}
                model.send('becameValid') if not model.get('isValid')
                model.set('errors', null)
                model.rollback()
            @back()

)
