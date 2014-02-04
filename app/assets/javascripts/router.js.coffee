# For more information see: http://emberjs.com/guides/routing/

App.Router.map () ->
    @resource('notes',{queryParams:['tag']}, ->
        @resource('note',{path: '/:note_id'}, ->
            @route('edit', {path:'/edit'})
        )
        @route('new')
    )
