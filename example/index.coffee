callbacks = require "when/callbacks"
sequence = require "when/sequence"
readline = require "readline"
symfio = require "symfio"


rl = readline.createInterface
  input: process.stdin
  output: process.stdout

question = (message) -> -> callbacks.call rl.question.bind(rl), message

sequence([
  question "Gmail username: "
  question "Gmail password: "
  question "To: "
  question "Subject: "
  question "Text: "
]).spread (username, password, to, subject, text) ->
  container = symfio "example", __dirname
  container.set "mailTransportType", "smtp"
  container.set "mailTransportOptions",
    service: "gmail"
    auth:
      user: username
      pass: password

  container.injectAll [
    require ".."

    (sendMail) ->
      sendMail
        from: username
        to: to
        subject: subject
        text: text
      .then ->
        console.log "Mail sent"
      .then null, (err) ->
        console.log err
      .then ->
        rl.close()
        container.get "mailTransport"
      .then (mailTransport) ->
        mailTransport.close()
  ]
