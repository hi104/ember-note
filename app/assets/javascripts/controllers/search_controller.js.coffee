App.SearchController = Em.ArrayController.extend(

    searchParams: "note"
    isLoading: false
    meta: null

    avaiableMore:( ->
        return false unless @get('meta')
        total = @get('meta.pagination.total_count')
        page = @get('meta.pagination.page')
        per = @get('meta.pagination.per_page')
        console.log(page * per, total)
        if total > (page * per)
            true
        else
            false
    ).property('meta')

    _search:(params) ->

            model = @get('model')
            self = @
            success = (data) =>
                @set('isLoading', false)
                data.notes.forEach((note_id) ->
                    note = self.store.find('note', note_id)
                    model.addObject(note)
                )
                @set('meta', data.meta)

            fail = (reason) =>
                @set('isLoading', false)
                console.log reason

            @set('isLoading', true)
            $.ajax('/notes/search',
                data: params,
                success: success,
                fail: fail,
            )


    actions:
        search: ->

            return if Ember.isEmpty(@get('searchParams'))

            params = q: @get('searchParams')
            @get('model').clear()
            @_search(params)

        more: ->
            params = {
                  q: @get('meta.q'),
                  page: @get('meta.pagination.page')+ 1
            }

            @_search(params)

)
