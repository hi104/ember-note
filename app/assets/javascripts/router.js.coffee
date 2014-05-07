# For more information see: http://emberjs.com/guides/routing/

App.Router.map () ->
    @resource('notes', {queryParams:['tag']}, ->
        @resource('note',{path: '/:note_id'}, ->
            @route('edit', {path:'/edit'})
        )
        @route('new')
    )

    @resource('tags', ->
        @resource('tag',{path: '/:tag_id'}, ->
            @route('edit', {path:'/edit'})
        )
    )

    @route('search', path: '/search', queryParams:['q'])
