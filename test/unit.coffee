nodemailer = require "nodemailer"
symfio = require "symfio"
plugin = require "../lib/nodemailer"
suite = require "symfio-suite"


describe "contrib-nodemailer plugin", ->
  wrapper = suite.sandbox symfio, ->

  it "should call callback", wrapper ->
    plugin @container, =>
      @callback = @sandbox.stub()
      email = @container.get "email"
      email "test@example.com", "Subject", "Body", @callback

    @expect(@callback).to.have.been.calledOnce

  it "should send email without errors", wrapper ->
    @container.set "email host", "localhost"
    @container.set "email port", 25

    @sandbox.stub nodemailer, "createTransport"
    createTransport = nodemailer.createTransport
    transport = @sandbox.stub()
    createTransport.returns transport

    plugin @container, =>
      @expect(createTransport).to.have.been.calledOnce
      @expect(createTransport.firstCall.args[0]).to.equal "SMTP"
      
      @expect(createTransport.firstCall.args[1])
        .to.have.property("secureConnection").and.false
      
      @expect(createTransport.firstCall.args[1])
        .to.have.property("host").and.equal("localhost")

      @expect(createTransport.firstCall.args[1])
        .to.have.property("port").and.equal(25)

      transport.options = createTransport.firstCall.args[1]
      transport.sendMail = @sandbox.stub()

      email = @container.get "email"
      email "test@example.com", "Subject", "Body", ->

      @expect(transport.sendMail).to.have.been.calledOnce
