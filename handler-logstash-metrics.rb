#! /usr/bin/env ruby
require 'sensu-handler'
require 'json'
require 'socket'

class LogstashMetricsHandler < Sensu::Handler

  def handle
    metrics = {}
    @event['check']['output'].split("\n").each do |line|
      v = line.split(" ")    
      hostname = ::Socket.gethostname
      metrics = {
        :source        => hostname,
        :host          => @event['client']['name'],
        :check_name    => @event['check']['name'],
        :command       => @event['check']['command'],
        :metric => v[0],
        :value => v[1]
      }
      socket = UDPSocket.new
      socket.send(JSON.generate(metrics), 0, "127.0.0.1", 5514)
      socket.close
    end
  end
end
