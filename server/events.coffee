# Event model contains
#    - sound_id: id of the sound to play
#    - type: Type of the event. ie: PB Sale
#    - source: Source of the event. ie: Pink Beryl, Luxebox 
#    - message: Description of the event
#    - event_params -> dict
#    - createdAt: Time the record is added (auto generated)

Events = new Meteor.Collection "events"

if Meteor.isServer
  Meteor.startup ->
    # Set up our events creation api
    collectionApi = new CollectionAPI
      authToken: '97f0ad9e24ca5e0408a269748d7fe0a0'
      apiPath: 'api'
    collectionApi.addCollection Events, 'events'
    collectionApi.start()

    Events.before "insert", (userId, doc) ->
      doc.createdAt = Date.now()