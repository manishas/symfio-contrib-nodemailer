nodemailer = require "nodemailer"
symfio = require "symfio"
plugin = require "../lib/nodemailer"
suite = require "symfio-suite"


describe "contrib-nodemailer plugin", ->
  wrapper = suite.sandbox symfio, ->

  it "should define transport", wrapper ->
    plugin @container, ->

    transport = @container.get "mailer transport"

    @expect(transport.sendMail).to.be.a "function"
