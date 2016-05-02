'use strict';
util           = require 'util'
{EventEmitter} = require 'events'
_              = require 'lodash'
debug          = require('debug')('meshblu-http-connector')
request        = require 'request'

MESSAGE_SCHEMA =
  type: 'object'
  properties:
    options:
      type: 'object'
      required: true

OPTIONS_SCHEMA = {}

class Plugin extends EventEmitter
  constructor: ->
    @options = {}
    @messageSchema = MESSAGE_SCHEMA
    @optionsSchema = OPTIONS_SCHEMA

  onMessage: (message) =>
    options = _.get message, 'payload.options'
    return if _.isEmpty options
    return unless options.uri? || options.url?
    debug 'got valid message', options
    request options, (error, response, body) =>
      return console.error error if error?
      message =
        devices: ['*']
        topic: 'http-response'
        payload:
          statusCode: response.statusCode
          body: body
      @emit 'message', message

  onConfig: (device) =>
    @setOptions device.options

  setOptions: (options={}) =>
    @options = options

module.exports =
  messageSchema: MESSAGE_SCHEMA
  optionsSchema: OPTIONS_SCHEMA
  Plugin: Plugin
