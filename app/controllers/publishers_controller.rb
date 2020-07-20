require 'mqlight'

class PublishersController < ApplicationController
  @@result = ""

  helper_method :getResult
  helper_method :setResult

  def getResult
    @@result
  end

  def setResult
    @@result = ""
  end

  def create
    address = params[:publisher][:address]
    port = params[:publisher][:port]
    topic = params[:publisher][:topic]
    content = params[:publisher][:content]

    amqpservice = 'amqp://' + address + ':' + port

    @@result = "Message published"
    begin
      client = Mqlight::BlockingClient.new(amqpservice)
      client.send(topic, content)

      rescue Exception => e
        @@result = e.message
    end

    redirect_to "/publishers/new"
  end
end
