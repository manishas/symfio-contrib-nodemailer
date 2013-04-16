nodemailer = require "nodemailer"
      

module.exports = (container, callback) ->
  username = container.get "email username"
  password = container.get "email password"
  service = container.get "email service"
  logger = container.get "logger"
  host = container.get "email host"
  port = container.get "email port"

  options =
    secureConnection: container.get("email connection secured") or false

  options.auth = user: username, pass: password if username and password

  if service
    options.service = service
  else
    options.host = host
    options.port = port

  transport = nodemailer.createTransport "SMTP", options

  container.set "email", (to, subject, body, callback) ->
    options = transport.options
    unless options.service or (host and port)
      return callback "transport not configured"

    message =
      to: to
      subject: subject
      text: body

    transport.sendMail message, (err) ->
      callback err

  callback()
