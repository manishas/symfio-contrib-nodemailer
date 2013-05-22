symfio = require "symfio"

module.exports = container = symfio "example", __dirname

loader = container.get "loader"
loader.use require "../lib/nodemailer"

loader.use (container, callback) ->
  transport = container.get "mailer transport"

  transport.sendMail
    to: "test@example.com"
    subject: "Subject"
    text: "Body"
  , (err) ->
    callback()

loader.load() if require.main is module
