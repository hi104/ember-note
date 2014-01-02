Ember.Handlebars.registerBoundHelper('formatDate', (date, format) ->
  moment(date).format(format);
)

Ember.Handlebars.registerBoundHelper('markdown', (data) ->
    return null unless data
    new Handlebars.SafeString(marked(data));
)
