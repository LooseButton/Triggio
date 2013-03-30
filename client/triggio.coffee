Events = new Meteor.Collection "events"

if Meteor.isClient
  Meteor.startup ->
    # current_time = new Date().valueOf()
    Events.find().observe
      addedAt: (target_event, index, before) ->
        console.log target_event
        console.log index
        console.log before
        console.log 'events added!'
        
  Template.events.events = ->
    # Display all events
    Events.find()