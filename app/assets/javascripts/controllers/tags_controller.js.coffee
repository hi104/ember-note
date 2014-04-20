App.TagsIndexController = Em.ArrayController.extend(

    sortProperties: ['name']

    editingModel:null

    actions:
        delete:(tag)->

            if(window.confirm('Are you sure？'))
                tag.deleteRecord()
                tag.save().then(=>
                    taggings = @get('store').typeMapFor(App.Tagging).records
                    for tagging in taggings
                        if tagging and tagging.get('tag').get('isDeleted')
                            tagging.deleteRecord();
                            tagging.transitionTo('deleted.saved');
                ,(reason)=>
                    tag.rollback()
                    Bootstrap.GNM.push('Error!', reason.statusText, 'error');
                )

        # edit:(tag)->
        #     return if @get('editingModel') == tag
        #     if @get('editingModel')
        #         @get('editingModel').cancelEdit()
        #         @get('editingModel').set('isEditing', false)

        #     @set('editingModel', tag)
        #     tag.set('isEditing', true)
        #     console.log('tags.index edit', tag)

        # save:(model)->
        #     model.save().then((data)=>
        #         Bootstrap.GNM.push('SUCCESS!', 'Save Success', 'success');
        #         @set('editingModel', null)
        #         model.set('isEditing', false)
        #     ,(result) =>
        #         if not (result instanceof DS.InvalidError)
        #             Bootstrap.GNM.push('Error!',  result.statusText, 'danger');
        #     )
)

App.TagController = Em.ObjectController.extend(

)

App.TagEditController = Em.ObjectController.extend(
    actions:
        save: ->
            model = @get('model')
            model.save().then((data)=>
                Bootstrap.GNM.push('SUCCESS!', 'Save Success', 'success');
            ,(result) =>
                if not (result instanceof DS.InvalidError)
                    Bootstrap.GNM.push('Error!',  result.statusText, 'danger');
            )
)
