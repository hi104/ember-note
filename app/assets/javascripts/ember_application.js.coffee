#= require handlebars-v1.1.2.js
#= require ./setup.js
#= require ember_canary.js
#= require ember-data_1_0.js
#= require ember-addons.bs_for_ember/dist/js/bs-core.min.js
#= require ember-addons.bs_for_ember/dist/js/bs-notifications.min.js
#= require ember-addons.bs_for_ember/dist/js/bs-growl-notifications.min.js
#= require_self
#= require ember_note
#
# for more details see: http://emberjs.com/guides/application/
#
window.App = window.EmberNote = Ember.Application.create({
    # LOG_TRANSITIONS: true,
    # LOG_TRANSITIONS_INTERNAL: true
})


App.NoteAdapter = DS.ActiveModelAdapter
App.TagAdapter = DS.ActiveModelAdapter
App.TaggingAdapter = DS.ActiveModelAdapter
