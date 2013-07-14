suite = require "symfio-suite"


describe "contrib-nodemailer plugin", ->
  it = suite.plugin (container) ->
    container.inject ["suite/container"], require ".."

    container.set "mailTransportType", "sendmail"
    container.set "mailTransportOptions", {}
    container.set "nodemailer", (sandbox) ->
      createTransport: sandbox.spy()

  describe "container.require nodemailer", ->
    it "should require nodemailer", (required) ->
      required("nodemailer").should.equal "nodemailer"

  describe "container.unless mailTransportType", ->
    it "should be sendmail by default", (unlessed) ->
      factory = unlessed "mailTransportType"
      factory().should.eventually.equal "sendmail"

  describe "container.unless mailTransportOptions", ->
    it "should be sendmail by default", (unlessed) ->
      factory = unlessed "mailTransportOptions"
      factory().should.eventually.eql {}

  describe "container.set mailTransport", ->
    it "should create transport", (setted, nodemailer) ->
      factory = setted "mailTransport"
      factory().then ->
        nodemailer.createTransport.should.be.calledOnce
        nodemailer.createTransport.should.be.calledWith "sendmail", {}
