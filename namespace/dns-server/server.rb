#!/usr/bin/env ruby
gem 'async'

require 'async/dns'

class DNSObject
    attr_reader :protocol, :address, :port
    def initialize options={}
        @protocol = options[:protocol]
        @address = options[:address]
        @port = options[:port]
    end

    def to_a
        protocol ?
            [protocol, address, port] :
            %i[udp tcp].reduce([]) { |res, _protocol| res << [_protocol, address, port] }
    end
end

class DNSServer < Async::DNS::Server
    private def google_dns
        DNSObject.new(address: '8.8.8.8', port: 53).to_a
    end
    def process name, resource_class, transaction
        @resolver ||= Async::DNS::Resolver.new google_dns
        if name =~ /#{ARGV[3]}/ # change pattern to domain
            pp "catch question: #{name} response catch answer: #{transaction.respond!("127.0.0.1").map {|answer| answer.address}}"
        else
            transaction.passthrough! @resolver
            pp "answer #{name}"
        end
    end
end

params = lambda do
    if ARGV.size < 1
        puts "Usage: protocol://ipv4:port:domain"
        exit
    end
    {protocol: ARGV[0] || 'udp', address: ARGV[1] || '127.0.0.1', port: ARGV[2] || 12333}
end.call

resolver = DNSObject.new(params)
pp resolver.to_a
server = DNSServer.new([resolver.to_a])
puts "Start Own My DNS, on #{params[:port]}"
server.run
