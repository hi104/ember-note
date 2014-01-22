#NOTE better move to model
App.noteSortPropetyies = [
    {
        key:'name',
        name:'name',
        asc:true
    },
    {
        key:'updated_at',
        name:'updated_at',
        asc:false
    },
    {
        key:'created_at',
        name:'created_at',
        asc:false
    }
]

App.NotesController = Em.ArrayController.extend(
    needs: "note",
    sortProperties: ['updated_at']
    sortAscending: false
    tagText: ""
    queryTags: Ember.A()
    queryCategory: ''
    sortProperty: App.noteSortPropetyies[0]
    searching: false

    changeSortPrperty:(->
        sort = @get('sortProperty')
        @set('sortProperties',[sort.key])
        @set('sortAscending',sort.asc)
    ).observes('sortProperty')

    changeQueryTags:(->
        unless @get('searching')
            Ember.run.debounce(@, @transitionUseQuery, 30)
    ).observes('queryTags.@each')

    transitionUseQuery:()->
        queryParams = {}
        if @get('queryTags').length > 0
            queryParams['tag'] = @get('queryTags').join()
        else
            queryParams['tag'] = null
        @transitionToRoute('notes', { queryParams: queryParams})
        $('#note-list').scrollTop(0) #NOTE direct access

    satQueryParams:(queryParams)->
        @set('queryCategory', queryParams["category"])
        query_tag = queryParams["tag"]

        if (typeof query_tag == 'string') and query_tag != ""
            tag_names = query_tag.trim().split(',').filter((e) -> e.length > 0)
            @set('queryTags', Ember.A(tag_names).uniq())
        else
            tag_ids = []
            @set('queryTags', Ember.A([]))

    getTagIds:(tag_names)->
        tags = App.tags
        tag_names.map((e) ->
            tag = tags.findBy('name', e)
            if tag
                tag.get('id')
            else
                null
        )

    hide:->
        @set('content.filterFunction', (e) -> false)

    search:(queryParams)->
        #better? suspend observe
        @set('searching', true)
        @satQueryParams(queryParams)
        @set('searching', false)

        # tag_names =  @get('queryTags').filter((e) -> e.match(/^#/)).map((e) -> e.replace('#',''))
        tag_names = @get('queryTags').map((e)->e)
        tag_ids = @getTagIds(tag_names)

        tag_filter_fn = (note)->
            return false unless note._data['taggings']
            note_tag_ids = note._data['taggings'].map((e)->
                e.get('tag').get('id')
            )
            Ember.A(tag_ids)["every"]((e) ->
                note_tag_ids.contains(e)
            )

        names =  @get('queryTags').filter((e) -> not e.match(/^#/))
        name_filter_fn = (note) ->
            names.any((e) ->
                escaped = e.replace(/\W/g,"\\$&")
                reg = new RegExp(escaped, 'ig')
                note_name = note._data['name']
                return false unless note_name
                note_name.match(reg)
            )

        filters = Ember.A()
        filters.pushObject(tag_filter_fn)
        filters.pushObject(name_filter_fn) if names.length > 0

        filter_fn = (note)->
            filters["any"]((e) -> e.call(@, note))

        @set('model.filterFunction', filter_fn)

    actions:
        edit:->
            model = @get('controllers.note').get('model')
            @transitionToRoute('note.edit', model)

        delete:(note)->
            if(window.confirm('Are you sure？'))
                taggings = note.get('taggings')
                taggings = taggings.content
                notes = @get('arrangedContent')
                index = notes.indexOf(note)
                next_note = notes.objectAt(index + 1)

                note.deleteRecord()
                note.save().then(=>
                    for tag in taggings
                        if tag
                            tag.transitionTo('deleted.saved');
                    if next_note
                        @transitionToRoute('note.show', next_note.get('id'))
                    else
                        @transitionToRoute('notes')

                ,(reason)=>
                    note.rollback()
                    Bootstrap.GNM.push('Error!', reason.statusText, 'error');
                )
            else
                return

        changeSelection:(params)->
            model = @get('controllers.note').get('model')
            notes = @get('arrangedContent')
            unless model
                index = 0
            else
                index = notes.indexOf(model) + params.direction

            note = notes.objectAt(index)
            if note
                @transitionToRoute('note.show', note.get('id'))

)

App.NotesNewController = Em.ObjectController.extend(
    setNewModel:->
        @set('model', @store.createRecord('note', {name:""}))

    back:->
        @transitionToRoute('notes')

    actions:
        save:()->
            model = @get('model')
            model.save(@store).then((data)=>
                Bootstrap.GNM.push('SUCCESS!', 'Create Success', 'success');
                @transitionToRoute('note.show', model.get('id'))
            ,(result) =>
                if (result instanceof DS.InvalidError)

                else
                    Bootstrap.GNM.push('Error!', result.statusText, 'error');
            )

        cancel:()->
            model = @get('model')
            model.rollback()
            @back()
)
