#!/usr/bin/env ruby
require 'socket'

class Messasge
    def initialize
    end
end

class Question
    def initialize message
        @message = message
    end

    attr_reader :message, :size

    def run
        handler = UDPSocket.new
        handler.send message, 0, "127.0.0.1", "53"
        pp "run"
        msg, ipaddr = handler.recvfrom(4096)
        pp "msg: #{msg}, ipaddr: #{ipaddr}"
        handler.close
    end

    def self.perform message
        Question.new(message)
        puts "Send Question"
    end
end

msg = [%w[AA AA 01 00 00 01 00 00 00 00 00 00
07 65 78 61 6d 70 6c 65 03 63 6f 6d 00 00 01 00 01].join("")]
msg = msg.pack("H*")
pp "msg: #{msg}"
q = Question.new msg
q.run
