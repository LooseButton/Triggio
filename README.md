Triggio
=======

Web app that connects events send from trusted sources to sounds that are played.

Meteorite is used instead of meteor (https://github.com/oortcloud/meteorite)


## Audio files
Please provide audio clips in mp3 format. Since Triggio uses [audio.js](http://kolber.github.com/audiojs/) it support most browser with flash used as fallback

### Useful Commands

**Starting the server**
`mrt run`

**Collections API**
https://github.com/crazytoad/meteor-collectionapi

## Creating a record in terminal
    curl -H "X-Auth-Token: 97f0ad9e24ca5e0408a269748d7fe0a0" -d '{"sound_id": "eat-mushroom", "type": "Draco", "source": "PB", "message": "Draco Demo Stuff"}' http://localhost:3000/api/events
