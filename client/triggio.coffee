Events = new Meteor.Collection "events"

if Meteor.isClient
  Meteor.startup ->
    # Events.find().observe
    #   _suppress_initial: true
    #   added: (target_event) ->
    #     console.log target_event
    #     # console.log index
    #     # console.log before
    #     console.log 'events added!'
  Template.events.events = ->
      # Display all events
      Events.find()