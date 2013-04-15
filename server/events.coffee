# Event model contains
#    - sound_id: id of the sound to play
#    - type: Type of the event. ie: PB Sale
#    - source: Source of the event. ie: Pink Beryl, Luxebox 
#    - message: Description of the event
#    - event_params -> dict
#    - createdAt: Time the record is added (auto generated)

Events = new Meteor.Collection "events"
Meteor.publish("events", ->
  user = Meteor.users.findOne({_id: @.userId})
  if !(user is undefined)
    userEmails = user.emails
    for e in userEmails
      if e.verified is true and e.address in Meteor.settings.authorizedEmails
        return Events.find {},
          sort: { 'createdAt': -1 }
          limit: 15
  return Events.find limit: 0
)

# Set up a callback for twillio message to add event
Fiber = Npm.require("fibers")
connect = Npm.require('connect')
app = __meteor_bootstrap__.app
regex = /(.+)\((.+)\)/
router = connect.middleware.router (route) ->
  route.get '/receive-sms', (req, res) ->
    Fiber () ->
      body = req.query['Body']
      body = body.split(regex)
      msg = body[1]
      sound_id = body[2]
      Events.insert
        type: 'sms'
        message: msg
        sound_id: sound_id
    .run()
    res.writeHead(200)
    res.end()
app.use(router)

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

    process.env.MAIL_URL = "smtp://#{Meteor.settings.emailUser}:#{Meteor.settings.emailPass}@#{Meteor.settings.emailHost}:#{Meteor.settings.emailPort}"

    Accounts.config sendVerificationEmail: true, forbidClientAccountCreation: false
