App.ApplicationRoute = Ember.Route.extend(
    model:(params)->
        Ember.RSVP.hash(
            notes : @store.find('note'),
            tags : @store.find('tag')
        )

    setupController:(controller, model)->
        App.set('tags', model.tags)

    actions:
        error: (error, transition)->
            Bootstrap.GNM.push('Error!', error.message, 'error');

)
