# for more details see: http://emberjs.com/guides/views/
App.NoteShowView = Ember.View.extend
    templateName: 'note/show'

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
        $('#sidebar').css('margin-left', '-280px')
        $('#note').css('margin-left', '0px')
    resetEditLayout:->
        $('#sidebar').css('margin-left', '0px')
        $('#note').css('margin-left', '280px')

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

        @setEditLayout()
    willDestroyElement: ->
        $('#note').off('keydown', @keyDown)
        @resetEditLayout()

App.NotesNewView = App.NoteFormView.extend
    didInsertElement:->
        @setEditLayout()

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

    willDestroyElement: ->
        $('#note-list').off('keydown', @keydown)

    didInsertElement: ->
        el = $('#note-list')
        el.on('keydown', { _self: @ }, @keyDown)
        el.focus()
