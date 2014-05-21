App.Tag = DS.Model.extend
    name: DS.attr 'string'
    color: DS.attr 'string'
    taggings_count: DS.attr 'number'
    taggings: DS.hasMany 'tagging'

    isEditing: false

    cancelEdit: ->
        if @get('isDirty')
            @_inFlightAttributes = {}
            @send('becameValid') if not @get('isValid')
            @set('errors', null)
            @rollback()

    styleColor:(->
        'background-color:' + @get('color')
    ).property('color')
