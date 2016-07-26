#! /usr/bin/env ruby
require 'sensu-handler'
require 'json'
require 'socket'

class LogstashChecksHandler < Sensu::Handler

  def action_to_string
    @event['action'].eql?('resolve') ? 'RESOLVE' : 'ALERT'
  end

  def event_status
    case @event['check']['status']
    when 0
      'OK'
    when 1
      'WARNING'
    when 2
      'CRITICAL'
    else
      'unknown'
    end
  end

  def handle
    check = {}
    hostname = ::Socket.gethostname
    check = {
      :source        => hostname,
      :tags          => ["sensu-#{action_to_string}"],
      :message       => @event['check']['output'],
      :host          => @event['client']['name'],
      :timestamp     => @event['check']['issued'],
      :address       => @event['client']['address'],
      :check_name    => @event['check']['name'],
      :command       => @event['check']['command'],
      :status        => event_status,
      :flapping      => @event['check']['flapping'],
      :occurrences   => @event['occurrences'],
      :action        => @event['action']
    }
      socket = UDPSocket.new
      socket.send(JSON.generate(check), 0, "127.0.0.1", 5514)
      socket.close
    end
  end
end