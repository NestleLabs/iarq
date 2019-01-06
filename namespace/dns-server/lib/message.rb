#!/usr/bin/env ruby
require 'socket'

class Messasge
    def initialize
    end
end

class Question
    def initialize message
        @message = message
        @size = message.size
    end

    attr_reader :message, :size

    def run
        handler = UDPSocket.new
        handler.send message, size, "127.0.0.1", "23333"
        handler.close
    end

    def self.perform message
        Question.new(message)
        puts "Send Question"
    end
end
