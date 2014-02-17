App.NoteRoute = Ember.Route.extend(
    model:(params)->
        model = @store.getById('note', params.note_id)
        unless model.get('content')
            model.reload()
        else
            model

    renderTemplate:->
        @._super()
        setTimeout(@adjustListScroll, 0)

    #better code move to view ?
    adjustListScroll:->
        el = $('#note-list .active')[0]

        if el
            list_el      = $('#note-list')
            scroll_top   = list_el.scrollTop()
            list_height  = list_el.height()
            adjust       = list_height / 3
            position     = $(el).position()

            if position.top < 0 #over top
                list_el.scrollTop(scroll_top + position.top - adjust)

            if position.top > list_height #over bottom
                list_el.scrollTop(scroll_top + position.top - list_height + adjust)
)

App.NoteIndexRoute = Ember.Route.extend(
    setupController:(controller, model)->
        @._super.apply(@, arguments)
        @controller.set('model', @controllerFor('note').get('model'))
)


App.NoteEditRoute = Ember.Route.extend(
    setupController:(controller, model)->
        @._super.apply(@, arguments)
        @controller.set('model', @controllerFor('note').get('model'))
)
