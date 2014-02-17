# for more details see: http://emberjs.com/guides/models/defining-models/

EmberNote.NoteAttachment = DS.Model.extend
  attachment: DS.attr 'string'
  note: DS.belongsTo 'EmberNote.Note'
