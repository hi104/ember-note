App.SearchController = Em.ArrayController.extend(

    searchParams: ""
    isLoading: false
    meta: null

    avaiableMore:( ->
        return false unless @get('meta')
        total = @get('meta.pagination.total_count')
        page = @get('meta.pagination.page')
        per = @get('meta.pagination.per_page')
        if total > (page * per)
            true
        else
            false
    ).property('meta')

    zeroResults:(->
        return false unless @get('meta')
        total = @get('meta.pagination.total_count')
        total == 0
    ).property('meta')

    _search:(params) ->

        return unless params.q

        model = @get('model')
        self = @
        success = (data) =>
            @set('isLoading', false)
            data.notes.forEach((note_id) ->
                note = self.store.find('note', note_id)
                model.addObject(note)
            )
            @set('meta', data.meta)

        error = (reason) =>
            Bootstrap.GNM.push('Error!', reason.statusText, 'error');
            @set('isLoading', false)

        @set('isLoading', true)
        $.ajax('/notes/search',
            data: params,
            success: success,
            error: error
        )

    actions:
        search: ->

            return if Ember.isEmpty(@get('searchParams'))

            params = q: @get('searchParams')
            @get('model').clear()
            @set('meta', null)
            @transitionToRoute('search', { queryParams: params})

        more: ->
            params = {
                  q: @get('meta.q'),
                  page: @get('meta.pagination.page')+ 1
            }

            @_search(params)

)
