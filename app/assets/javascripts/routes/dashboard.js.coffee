App.DashboardRoute = Ember.Route.extend(

    setupController:(controller, model)->
        @._super.apply(@, arguments)

        notes = @store.all('note').sortBy('updated_at').reverse().slice(0, 5)
        controller.set('notes', notes)
)
