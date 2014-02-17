#= require ./store
#= require_tree ./serializers
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes
#= require_tree ./utils
#= require ./router
#= require_self
#
#
# for rest routing
App.Store = DS.Store.extend();
