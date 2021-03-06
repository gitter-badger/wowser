EventEmitter = require('events')
Message = require('./message')

class ChatHandler extends EventEmitter
  module.exports = this

  # Creates a new chat handler
  constructor: (session) ->

    # Holds session
    @session = session

    # Holds messages
    @messages = []

    # Listen for messages
    @session.game.on 'packet:receive:SMSG_MESSAGE_CHAT', @handleMessage.bind(this)

  # Sends given message
  send: (message) ->
    throw new Error 'sending chat messages is not yet implemented'

  # Message handler (SMSG_MESSAGE_CHAT)
  handleMessage: (gp) ->
    type = gp.readUnsignedByte()
    lang = gp.readUnsignedInt()
    guid1 = gp.readGUID()
    gp.readUnsignedInt()
    guid2 = gp.readGUID()
    len = gp.readUnsignedInt()
    text = gp.readString(len)
    flags = gp.readUnsignedByte()

    message = new Message()
    message.text = text
    message.guid = guid1

    @messages.push(message)

    @emit 'message', message
