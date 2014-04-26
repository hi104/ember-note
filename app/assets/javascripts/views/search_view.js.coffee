App.SearchView = Ember.View.extend
    templateName: 'search'

    keyDown: (e)->
        return unless e.data
        if e.keyCode == 13 # key Enter
            self = e.data._self
            self.get('controller').send('search')

    willDestroyElement: ->
        $('#inputSearch').off('keydown', @keyDown)

    didInsertElement:->
        $('#inputSearch').on('keydown', { _self: @ }, @keyDown);
        $('#inputSearch').focus()
