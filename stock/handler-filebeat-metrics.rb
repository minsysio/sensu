#! /usr/bin/env ruby
#see : https://github.com/inokappa/sensu-handler-metrics-elasticsearch/blob/master/elasticsearch-metrics.rb
require 'sensu-handler'
require 'json'

class FilebeatMetricsHandler < Sensu::Handler

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
      File.open("/var/log/minsys/sensu/test01-metrics.json", 'a') {|f| f.write(JSON.generate(metrics))} 
    end
  end
end

#      File.open("/var/log/minsys/sensu/#{hostname}-metrics-tmp.json", 'w') {|f| f.write(JSON.generate(metrics))} 
#require 'fileutils'
#     FileUtils.mv("/var/log/minsys/sensu/#{hostname}-metrics-tmp.json", "/var/log/minsys/sensu/#{hostname}-metrics.json")

#{"@timestamp":"2016-07-23T21:15:07Z","@version":1,"source":"ovh-head","tags":["sensu-ALERT"],
#  "message":"vivado.cpu.total.user 3670935 1469308557\nvivado.cpu.total.nice 34474 1469308557\nvivado.cpu.total.system 1155392 1469308557\nvivado.cpu.total.idle 2703789980 1469308557\nvivado.cpu.total.iowait 1363028 1469308557\nvivado.cpu.total.irq 508 1469308557\nvivado.cpu.total.softirq 78523 1469308557\nvivado.cpu.total.steal 0 1469308557\nvivado.cpu.total.guest 0 1469308557\nvivado.cpu.total. 0 1469308557\nvivado.cpu.cpu0.user 896881 1469308557\nvivado.cpu.cpu0.nice 9375 1469308557\nvivado.cpu.cpu0.system 240928 1469308557\nvivado.cpu.cpu0.idle 336655626 1469308557\nvivado.cpu.cpu0.iowait 370740 1469308557\nvivado.cpu.cpu0.irq 498 1469308557\nvivado.cpu.cpu0.softirq 29455 1469308557\nvivado.cpu.cpu0.steal 0 1469308557\nvivado.cpu.cpu0.guest 0 1469308557\nvivado.cpu.cpu0. 0 1469308557\nvivado.cpu.cpu1.user 829340 1469308557\nvivado.cpu.cpu1.nice 7341 1469308557\nvivado.cpu.cpu1.system 234381 1469308557\nvivado.cpu.cpu1.idle 337229063 1469308557\nvivado.cpu.cpu1.iowait 481355 1469308557\nvivado.cpu.cpu1.irq 3 1469308557\nvivado.cpu.cpu1.softirq 22391 1469308557\nvivado.cpu.cpu1.steal 0 1469308557\nvivado.cpu.cpu1.guest 0 1469308557\nvivado.cpu.cpu1. 0 1469308557\nvivado.cpu.cpu2.user 636934 1469308557\nvivado.cpu.cpu2.nice 5766 1469308557\nvivado.cpu.cpu2.system 237289 1469308557\nvivado.cpu.cpu2.idle 337722556 1469308557\nvivado.cpu.cpu2.iowait 167806 1469308557\nvivado.cpu.cpu2.irq 5 1469308557\nvivado.cpu.cpu2.softirq 18691 1469308557\nvivado.cpu.cpu2.steal 0 1469308557\nvivado.cpu.cpu2.guest 0 1469308557\nvivado.cpu.cpu2. 0 1469308557\nvivado.cpu.cpu3.user 1018250 1469308557\nvivado.cpu.cpu3.nice 10333 1469308557\nvivado.cpu.cpu3.system 246492 1469308557\nvivado.cpu.cpu3.idle 337192909 1469308557\nvivado.cpu.cpu3.iowait 337039 1469308557\nvivado.cpu.cpu3.irq 0 1469308557\nvivado.cpu.cpu3.softirq 4906 1469308557\nvivado.cpu.cpu3.steal 0 1469308557\nvivado.cpu.cpu3.guest 0 1469308557\nvivado.cpu.cpu3. 0 1469308557\nvivado.cpu.cpu4.user 80776 1469308557\nvivado.cpu.cpu4.nice 1 1469308557\nvivado.cpu.cpu4.system 49309 1469308557\nvivado.cpu.cpu4.idle 338750161 1469308557\nvivado.cpu.cpu4.iowait 813 1469308557\nvivado.cpu.cpu4.irq 0 1469308557\nvivado.cpu.cpu4.softirq 1158 1469308557\nvivado.cpu.cpu4.steal 0 1469308557\nvivado.cpu.cpu4.guest 0 1469308557\nvivado.cpu.cpu4. 0 1469308557\nvivado.cpu.cpu5.user 37513 1469308557\nvivado.cpu.cpu5.nice 0 1469308557\nvivado.cpu.cpu5.system 45565 1469308557\nvivado.cpu.cpu5.idle 338803063 1469308557\nvivado.cpu.cpu5.iowait 794 1469308557\nvivado.cpu.cpu5.irq 0 1469308557\nvivado.cpu.cpu5.softirq 187 1469308557\nvivado.cpu.cpu5.steal 0 1469308557\nvivado.cpu.cpu5.guest 0 1469308557\nvivado.cpu.cpu5. 0 1469308557\nvivado.cpu.cpu6.user 38479 1469308557\nvivado.cpu.cpu6.nice 0 1469308557\nvivado.cpu.cpu6.system 46118 1469308557\nvivado.cpu.cpu6.idle 338798413 1469308557\nvivado.cpu.cpu6.iowait 661 1469308557\nvivado.cpu.cpu6.irq 0 1469308557\nvivado.cpu.cpu6.softirq 118 1469308557\nvivado.cpu.cpu6.steal 0 1469308557\nvivado.cpu.cpu6.guest 0 1469308557\nvivado.cpu.cpu6. 0 1469308557\nvivado.cpu.cpu7.user 132758 1469308557\nvivado.cpu.cpu7.nice 1656 1469308557\nvivado.cpu.cpu7.system 55307 1469308557\nvivado.cpu.cpu7.idle 338638186 1469308557\nvivado.cpu.cpu7.iowait 3818 1469308557\nvivado.cpu.cpu7.irq 0 1469308557\nvivado.cpu.cpu7.softirq 1614 1469308557\nvivado.cpu.cpu7.steal 0 1469308557\nvivado.cpu.cpu7.guest 0 1469308557\nvivado.cpu.cpu7. 0 1469308557\nvivado.cpu.intr 0 1469308557\nvivado.cpu.ctxt 617330172 1469308557\nvivado.cpu.btime 1465919597 1469308557\nvivado.cpu.processes 4068822 1469308557\nvivado.cpu.procs_running 1 1469308557\nvivado.cpu.procs_blocked 0 1469308557\nvivado.cpu.cpu_count 8 1469308557\n",
#  "host":"vivado",
#  "timestamp":1469308507,
#  "address":"WAN_vivado.ip-maker.cloud.minsys.io",
#  "check_name":"CPU_metrics",
#  "command":"metrics-cpu.rb",
#  "status":"OK",
#  "flapping":null,
#  "occurrences":1,
#  "action":"create"}

#    filebeat_metrics[:type] = settings['logstash']['type'] if settings['logstash'].key?('type')
#   logfile = "/var/log/minsys/sensu/metrics.json"
#    File.write('/path/to/file', JSON.generate(filebeat_metrics) ) 
#    JSON.generate(filebeat_metrics), 0, settings['logstash']['server'], settings['logstash']['port'])
#    case settings['logstash']['output']
#    when 'redis'
#      redis = Redis.new(host: settings['logstash']['server'], port: settings['logstash']['port'])
#      redis.lpush(settings['logstash']['list'], filebeat_metrics.to_json)
#    when 'udp'
#      socket = UDPSocket.new
#      socket.send(JSON.generate(filebeat_metrics), 0, settings['logstash']['server'], settings['logstash']['port'])
#      socket.close
#    when 'tcp'
#      socket = TCPSocket.new(settings['logstash']['server'], settings['logstash']['port'])
#      socket.puts(JSON.generate(filebeat_metrics))
#      socket.close
#    end
#    
