module.exports = (container) ->
  container.require require
  container.require "nodemailer"
  container.require "nodefn", "when/node/function"

  container.unless "mailTransportType", "sendmail"
  container.unless "mailTransportOptions", {}

  container.set "mailTransport",
    (nodemailer, mailTransportType, mailTransportOptions) ->
      nodemailer.createTransport mailTransportType, mailTransportOptions

  container.set "sendMail", (mailTransport, nodefn) ->
    ->
      nodefn.apply mailTransport.sendMail.bind(mailTransport), arguments
