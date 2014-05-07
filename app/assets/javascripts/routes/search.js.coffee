App.SearchRoute = Ember.Route.extend(

    setupController:(controller, model, queryParams)->
        @._super.apply(@, arguments)
        controller.set('searchParams', queryParams.q)
        controller._search(q: queryParams.q)
)
