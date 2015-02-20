# Description:
#   Turn Hubot into a lovely conversational partner
#
# Dependencies:
#   A redis server to store state in
#   epichal
#   redis
#
# Configuration:
#   REDISTOGO_URL || REDISCLOUD_URL || BOXEN_REDIS_URL
#
# Commands:
#   <robot>: <msg>  - epichal will respond to your message
#
# Author:
#   rcs (github.com/rcs)
#
EpicHAL = require('epichal/src/epichal')
RedisStorage = require('epichal/src/storage/redis')
Redis = require('redis')
Url = require('url')

module.exports = (robot) ->

  # Make the redis connection like redis brain
  info = Url.parse(
    process.env.REDISTOGO_URL ||
    process.env.REDISCLOUD_URL ||
    process.env.BOXEN_REDIS_URL ||
    'redis://localhost:6379'
  )

  client = Redis.createClient(info.port, info.hostname)

  if info.auth
    client.auth(info.auth.split(':')[1])

  eh = EpicHAL({
    storage: RedisStorage({
      client: client
    })
  })

  robot.hear /.{5,}/, (msg) ->

    return unless msg.message.text and msg.message.room

    maybeName = msg.message.text.split(/\b/)[0]

    unless maybeName.toUpperCase() == robot.name.toUpperCase()
      eh.learn msg.message.text, ->
        robot.logger.debug 'learned ' + msg.message.text

  robot.hear /.+/, (msg) ->
    return unless msg.message.text

    maybeName = msg.message.text.split(/\b/)[0]
    if maybeName.toUpperCase() == robot.name.toUpperCase()
      robot.logger.debug 'Responding from EpicHAL'
      eh.reply split.slice(2).join(''), ( err, res ) ->
        msg.send res
