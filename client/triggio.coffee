Events = new Meteor.Collection "events"

if Meteor.isClient

  # For testing
  window.play_sound ||= play_sound

  Meteor.startup ->

    # Observe for events added after startup and play corresponding sound clip
    current_time = Date.now()
    Events.find().observe
      addedAt: (target_event, index, before) ->
        if target_event.createdAt > current_time
          play_sound target_event.sound_id
        
  # Populate our events list
  Template.events.events = ->
    # Display all events
    Events.find {},
      sort: { 'createdAt': -1 }
      limit: 30

  # Events formatting
  Template.events.rendered = ->
    format_list_effect @findAll('.event')

# --------------------------------------------

format_list_effect = (all_events) ->
  current_index = 0
  _.each all_events, (one_event) ->
    $(one_event).css
      opacity: (1 - current_index * 0.08)
    current_index++


format_threed_effect = (all_events) ->
  console.log 'in development'
  y_space = 200
  z_space = 200
  current_index = 1
  translate_y = y_space *-1
  translate_z = z_space *-1
  all_events = @findAll('.event')
  z_index = all_events.length
  _.each all_events, (one_event) ->
    $(one_event).css
      '-webkit-transform': "translate3d(0px, #{translate_y}px, #{translate_z}px)"
      'z-index': z_index
    
    $(one_event).data 'translate_y', translate_y
    $(one_event).data 'translate_z', translate_z
    
    z_index--;
    translate_y -= y_space
    translate_z -= z_space

play_sound = (sound_id) ->
  # Remove any existing audio players
  $('#clip_player').remove()
  $('.audiojs').remove()

  # Create a new audio player that autoplays
  # This is done so audiojs can do its flash initialization if browser does not support mp3
  audio = $('<audio>').attr
    id: 'clip_player'
    autoplay: true
    preload: 'auto'
    hidden: 'hidden'
    src: "/clips/#{sound_id}.mp3"
  $('body').append audio
  audiojs.createAll()
