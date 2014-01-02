App.IndexRoute = Ember.Route.extend(
    redirect: ->
        this.transitionTo('notes');
)
