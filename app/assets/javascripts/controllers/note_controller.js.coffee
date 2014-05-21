App.NoteController = Em.ObjectController.extend(

)

App.NoteIndexController = Em.ObjectController.extend
    needs:['notes']

    actions:
        delete:(note)->
            @get('controllers.notes').send('delete', note)

App.NoteEditController = Em.ObjectController.extend(
    back:->
        model = @get('model')
        @transitionToRoute('note.index', model.get('id'))
        $('#note-list').focus()

    actions:
        save:()->
            model = @get('model')
            model.save().then((data)=>
                model.cleanTaggings()
                Bootstrap.GNM.push('SUCCESS!', 'Save Success', 'success');
            ,(result) =>
                if not (result instanceof DS.InvalidError)
                    Bootstrap.GNM.push('Error!',  result.statusText, 'danger');
            )

        cancel:()->
            @get('model').cancelEdit()
            @back()

)
