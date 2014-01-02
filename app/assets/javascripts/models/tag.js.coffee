App.Tag = DS.Model.extend
    name: DS.attr 'string'
    taggings: DS.hasMany 'tagging'
