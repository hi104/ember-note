App.NoteIndexView = Ember.View.extend
    templateName: 'note/index'

    keyDown: (e)->

        return unless e.data
        self = e.data._self
        if e.keyCode == 37
            e.preventDefault()
            $('#note-list').focus()

        if e.keyCode == 69 # key e
            self.get('controller').controllerFor('notes').send('edit')

    willDestroyElement: ->
        $('#note').off('keydown', @keyDown)

    didInsertElement:->
        el = $('#note')
        el.on('keydown', { _self: @ }, @keyDown);

App.NoteFormView = Ember.View.extend

    setEditLayout:->
        #TODO better use class?
        $('#sidebar').css('margin-left', '-280px')
        $('#note').css('margin-left', '0px')

    resetEditLayout:->
        $('#sidebar').css('margin-left', '0px')
        $('#note').css('margin-left', '280px')

    syncScroll:->
        note_textarea = $('#inputNote')
        previewContent = $('#preview-content')
        editorHeight =  note_textarea[0].scrollHeight
        previewHeight = previewContent.height()
        ratio = note_textarea.scrollTop() / editorHeight;
        $('#preview').scrollTop(ratio * previewHeight)

    setSyncScroll:()->
        $('#inputNote').scroll(=>
            @syncScroll()
        )

    $getInputNote:() ->
        $('#inputNote')

    setImageUploader:()->
        $inputNote = @$getInputNote()
        self = @

        $inputNote.on("drop", (evt) ->
            evt.stopPropagation()
            evt.preventDefault()

            files = evt.originalEvent.dataTransfer.files
            file = files[0]
            note = self.get('controller').get('model')

            uploader = new NoteAttachmentUploader()
            uploader.upload(note, file).done((data)->
                attachment_url = data.attachment.attachment.url
                note_text = note.get('content')
                cursorPosition = $inputNote.prop("selectionStart")
                image_markdown = "![](#{attachment_url})"
                head = note_text.slice(0, cursorPosition)
                tail = note_text.slice(cursorPosition)
                markdown = [head, image_markdown, tail].join("\n")
                note.set('content', markdown)

            ).fail((data)->
                console.log(data)
            )
        )

    setTagInput:()->
        content = @get('controller').get('content')
        $('#noteTagInput').val(content.taggingsString())
        $('#noteTagInput').tagsinput({
            tagClass: (item) -> 'label label-default'
            ,
            typeahead: {
                source: App.tags.map((e) -> e.get('name'))
            }
        })

        #add tag input on blur
        tags_input = $('#noteTagInput').data('tagsinput')
        tags_input.$input.on('blur', =>
            $input = tags_input.$input
            if $input.val().length > 0
                tags_input.add($input.val())
                $input.val('')
        )

        $('#noteTagInput').on('change', ->
            content.set('tag_list', $(@).val())
        )

App.NoteEditView = App.NoteFormView.extend
    templateName: 'note/edit'

    keyDown: (e)->
        return unless e.data
        self = e.data._self
        controller = self.get('controller')

        if e.keyCode == 27
            controller.back()

    didInsertElement:->
        $('#inputName').focus()
        $("#note").on('keydown', { _self: @ }, @keyDown);

        @setTagInput()
        @setEditLayout()
        @setSyncScroll()
        @setImageUploader()

    willDestroyElement: ->
        $('#note').off('keydown', @keyDown)
        @$getInputNote().off('drop')
        @resetEditLayout()

App.NotesNewView = App.NoteFormView.extend
    didInsertElement:->
        @setTagInput()
        @setEditLayout()
        @setSyncScroll()

    willDestroyElement: ->
        @resetEditLayout()

App.NotesView = Ember.View.extend
    templateName: 'notes'

    keyDown: (e)->

        return unless e.data

        self = e.data._self
        offset = 0
        if e.keyCode == 38 # up
            offset = -1

        if  e.keyCode == 40 # down
            offset = 1

        if  e.keyCode == 68 # key d
            #NOTE more simple
            controller = self.get('controller')
            note = controller.get('controllers.note').get('model')
            controller.send('delete', note)


        if  e.keyCode == 69 # key e
            self.get('controller').send('edit')

        if e.keyCode == 39 or e.keyCode == 13 #right or enter
            e.preventDefault()
            $('#note').focus()

        if(offset != 0)
            e.preventDefault()
            self.get('controller').send('changeSelection', { direction: offset });

    inputAddTagKeyDown:(e)->
        return unless e.data
        self = e.data._self
        if e.keyCode == 13
            self.get('controller').addTag()

    documentKeyDown:(e)->
        if e.keyCode == 76 and e.ctrlKey # key C-l
            $("#inputSearchNote").focus()

    willDestroyElement: ->
        $('#note-list').off('keydown', @keydown)
        $(document).off('keydown', @documentKeyDown)

    didInsertElement: ->
        el = $('#note-list')
        el.on('keydown', { _self: @ }, @keyDown)
        el.focus()
        $(document).on('keydown', @documentKeyDown)
