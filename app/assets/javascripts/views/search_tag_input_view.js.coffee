App.TagInputView = Ember.View.extend
    templateName: 'tag_input'

    inputAddTagKeyDown:(e)->
        return unless e.data
        self = e.data._self
        if e.keyCode == 8
            if e.target.selectionStart == 0
                self.send('deleteTag', self.get('tags.lastObject'))


        if e.keyCode == 13
            e.preventDefault()
            self.send('addInputTag')

    addTag:(tag)->
        return if tag.length == 0
        array = @get('tags')
        array.pushObject(tag) unless array.contains(tag)

    inputElement: ->
        $(@get('inputTag').get('element'))

    willDestroyElement: ->
        @inputElement().off('keydown', { _self: @ }, @inputAddTagKeyDown)

    didInsertElement: ->
        @inputElement().on( 'keydown', { _self: @ }, @inputAddTagKeyDown)

    actions:
        deleteTag:(tag)->
            @set('tags', @get('tags').without(tag))

        addInputTag:()->
            @addTag(@get('tagText'))
            @set('tagText','')

App.SearchInputView = App.TagInputView.extend
    classNames: ["search-input-view"]

    didInsertElement: ->
        self = @
        $(@get('element')).on('keydown', 'input', (e) ->
            if e.keyCode == 9 # tab
                $('#note-list').focus() #NOTE direct
                e.preventDefault()
                controller = self.get('controller')  # direct access another controller
                items = controller.controllerFor('notes').get('arrangedContent')
                item = items.objectAt(0)
                controller.transitionToRoute('note.show', item.get('id')) if item

            if e.keyCode == 8 # back space
                if e.target.selectionStart == 0
                    self.send('deleteTag', self.get('tags.lastObject'))

            if e.keyCode == 13 # enter
                e.preventDefault()
                self.send('addInputTag')
        )

        $(@get('element')).find('input').typeahead({
            source: App.tags.map((e) -> e.get('name'))
            updater:(item) ->
                self.addTag(item)
                self.set('tagText', '')
                return ''
        })
