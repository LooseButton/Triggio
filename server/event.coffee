Event = new Meteor.Collection "events"

if Meteor.is_server
  Meteor.startup ->
    collectionApi = new CollectionAPI
      authToken: '97f0ad9e24ca5e0408a269748d7fe0a0'
      apiPath: 'api'
    collectionApi.addCollection Event, 'events'
    collectionApi.start()