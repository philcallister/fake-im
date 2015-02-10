# encoding: UTF-8

require 'celluloid/io'
require 'celluloid/autostart'

module FakeIM
  module Server

    class ConnectionServer
      include FakeIM::Util
      include Celluloid::IO
      include Celluloid::Logger

      finalizer :shutdown

      def initialize(args)
        info "*** Server: Starting on #{args[:host]}:#{args[:port]}"

        # Setup Celluloid::IO::TCPServer with Reactor. I started but didn't
        # finish turning this into a server that supports both 'Threaded'
        # and 'Evented I/O'. Currently this only supports 'Threaded'.
        @server = TCPServer.new(args[:host], args[:port])
        async.run
      end

      def shutdown
        info "*** Server: Shutdown..."
        @server.close unless @server.closed?
      rescue
        # do nothing
      end

      ## 
      # Accept incoming client connections. Spin off a new Celluloid Actor
      # for each connection.
      def run
        loop { async.connect @server.accept }
      rescue IOError, Errno::ECONNRESET
        info "*** Server: Socket closed"
      end

      ##
      # New client connection. Send it off on a new actor.
      def connect(socket)
        info "*** Server: Received connection from #{format_addr(socket)}"
        Connection.new(socket)
      end

    end

  end
end
