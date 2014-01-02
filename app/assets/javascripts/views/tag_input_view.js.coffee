App.TagInputView = Ember.View.extend
    templateName: 'tag_input'
    classNames:["tag-input-view"]

    inputAddTagKeyDown:(e)->
        return unless e.data
        self = e.data._self
        if e.keyCode == 8
            if e.target.selectionStart == 0
                self.send('deleteTag', self.get('tags.lastObject'))

        if e.keyCode == 13
            self.send('addInputTag')

        if  e.keyCode == 40
            $('#note-list').focus() #NOTE direct
            e.preventDefault()
            controller = self.get('controller')  # direct access another controlle r
            items = controller.controllerFor('notes').get('arrangedContent')
            item = items.objectAt(0)
            controller.transitionToRoute('note.show', item.get('id')) if item

    addTag:(tag)->
        return if tag.length == 0
        array = @get('tags')
        array.pushObject(tag) unless array.contains(tag)

    willDestroyElement: ->
        $("#input-add-tag").off('keydown', { _self: @ }, @inputAddTagKeyDown)

    didInsertElement: ->
        $("#input-add-tag").on( 'keydown', { _self: @ }, @inputAddTagKeyDown)

    actions:
        deleteTag:(tag)->
            @set('tags', @get('tags').without(tag))

        addInputTag:()->
            @addTag(@get('tagText'))
            @set('tagText','')
