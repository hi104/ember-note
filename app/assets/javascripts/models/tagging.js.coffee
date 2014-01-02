App.Tagging = DS.Model.extend
    tag: DS.belongsTo 'tag'
    note: DS.belongsTo 'note'
