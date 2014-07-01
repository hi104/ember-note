App.MarkDownView = Ember.View.extend
    templateName: 'markdown'

    onChangeContent: ->
        el = @get('element')
        Ember.run.scheduleOnce('afterRender', ()->
            emojify.run(el)
        )

    didInsertElement: ->
        emojify.run(@get('element'))
        @get('controller').addObserver('content.content', @onChangeContent)

    willDestroyElement: ->
        @get('controller').removeObserver('content.content', @onChangeContent)
