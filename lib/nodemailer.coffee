nodemailer = require "nodemailer"
      

module.exports = (container, callback) ->
  smtpTransportOptions = container.get "smtp transport options"
  smtpTransport = container.get "smtp transport", "sendmail"
  logger = container.get "logger"

  logger.info "loading plugin", "contrib-nodemailer"

  transport = nodemailer.createTransport smtpTransport. smtpTransportOptions

  container.set "mailer transport", transport

  callback()
