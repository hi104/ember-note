App.MarkDownView = Ember.View.extend
    templateName: 'markdown'
    
    onChangeContent: ->
        el = @get('element')
        Ember.run.scheduleOnce('afterRender', ()->
            emojify.run(el)
        )
        
    didInsertElement: ->
        emojify.run(@get('element'))
        @get('content').addObserver('content', @onChangeContent)

    willDestroyElement: ->
        @get('content').removeObserver('content', @onChangeContent)        
