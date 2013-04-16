# symfio-contrib-nodemailer

> Email sender plugin.

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

# You can use preconfigured services like Gmail or Hotmail.
# container.set "email service", "GMAIL"

# Or you can define custom SMTP server.
container.set "email host", "smtp.gmail.com"
container.set "email port", 465

container.set "email username", "user@gmail.com"
container.set "email password", "password"

loader = container.get "loader"

loader.use require "symfio-contrib-nodemailer"

loader.load()
```

## Must be configured

* __email service__
* __email host__
* __email port__

## Can be configured

* __email connection secured__ - Use secured SMTP connection. Default is `false`.
* __email username__
* __email password__
