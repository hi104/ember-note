App.Note = DS.Model.extend(
    name: DS.attr 'string'
    content: DS.attr 'string'
    label_color: DS.attr 'string'
    created_at: DS.attr 'date'
    updated_at: DS.attr 'date'
    tag_list: DS.attr 'string'
    taggings: DS.hasMany 'tagging'

    taggingsString:->
        @get('taggings').map((e) -> e.get('tag').get('name')).join(", ")

    cleanTaggings:->
        self = @
        updated_taggings = @get('taggings')
        taggings = @get('store').typeMapFor(App.Tagging).records.filter((e) ->
            e.get('note') == self
        )
        deleted = []
        taggings.forEach((tag) ->
            if not updated_taggings.contains(tag)
                deleted.push tag
        )
        for tag in deleted
            tag.unloadRecord()

    updatedAtFromNow:(->
        time = @get('updated_at')
        return null unless time
        moment(time).fromNow()
    ).property('updated_at')

    attachmentUploadUrl:()->
        '/notes/' + @get('id') + '/note_attachments.json'

    rowStyle:(->
        'border-left-color:' + @get('label_color')
    ).property('label_color')

    cancelEdit: ->
        if @get('isDirty')
            @_inFlightAttributes = {}
            @send('becameValid') if not @get('isValid')
            @set('errors', null)
            @rollback()
)
