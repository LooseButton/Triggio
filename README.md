Triggio
=======

Web app that connects events send from trusted sources to sounds that are played.


## Creating a record in terminal
    curl -H "X-Auth-Token: 97f0ad9e24ca5e0408a269748d7fe0a0" -d '{"sound_id": "eat-mushroom", "type": "PB Sub", "source": "PB", "message": "+1 Member!"}' http://localhost:3000/api/events
