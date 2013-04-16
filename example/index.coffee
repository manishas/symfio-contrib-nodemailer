symfio = require "symfio"

module.exports = container = symfio "example", __dirname
container.set "email host", "localhost"
container.set "email port", 25

loader = container.get "loader"
loader.use require "../lib/nodemailer"

loader.use (container, callback) ->
  email = container.get "email"
  email "test@example.com", "Subject", "Body", (err) ->
    callback()

loader.load() if require.main is module
