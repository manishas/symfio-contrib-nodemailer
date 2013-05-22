# symfio-contrib-nodemailer

> Email sender plugin.

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

container.set "smtp transport", "smtp"
container.set "smtp transport options",
  service: "gmail"
  auth:
    user: "example@gmail.com"
    pass: "password"

loader = container.get "loader"

loader.use require "symfio-contrib-nodemailer"

loader.use (container, callback) ->
  transport = container.get "mailer transport"

  transport.sendMail
    to: "test@example.com"
    subject: "Subject"
    text: "Body"
  , (err) ->
    callback()

loader.load()
```

## Can be configured

* __smtp transport__ - SMTP transport. Default is `sendmail`.
* __smtp transport options__
