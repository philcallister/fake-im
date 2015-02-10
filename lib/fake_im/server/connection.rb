# encoding: UTF-8

require 'celluloid/io'
require 'celluloid/autostart'

module FakeIM
  module Server

    class Connection < FakeIM::Command::ActorFacade
      include Celluloid::IO
      include Celluloid::Logger
      include Celluloid::Notifications
      include FakeIM::Util

      finalizer :shutdown

      def initialize(socket)
        info "*** Connection: Init for #{format_addr(socket)}"
        @socket = socket
        @auth = FakeIM::Command::Auth.new
        @groups = FakeIM::Command::Groups.new
        async.reader
      end

      def shutdown
        info "*** Connection: Shutdown..."
        @socket.close unless @socket.closed?
      rescue
        # do nothing
      end

      ##
      # Until we shutdown or until the client disconnects, read incoming messages
      # from the client. For each message, we'll build a new command using the
      # BaseCommand factory builder. Once the appropriate command has been built,
      # the command is executed.
      def reader
        loop do
          info "*** Connection: Waiting to read next message from #{format_addr(@socket)}"
          payload = @socket.readpartial(4096).chomp
          info "*** Connection: Command: '#{payload}' from #{format_addr(@socket)}"
          begin
            command = FakeIM::Command::BaseCommand.build_command(payload)
            command.execute(Celluloid::Actor.current, :receive_message, @auth, @groups) do |topic, message|
              Celluloid::Actor[:storage].async.store_message(topic, message)
            end
          rescue FakeIM::Exceptions::AuthenticationError
            send_message("ERROR: Not logged in")
          rescue ArgumentError, FakeIM::Exceptions::InvalidCommandError
            send_message("ERROR: Invalid command")
          end
        end
      rescue IOError, Errno::ECONNRESET
        info "*** Connection: Reader disconnected"
      end

      ##
      # Send all messages back to the connected client
      def send_message(message)
        info "*** Connection: Send message: '#{message}' from #{format_addr(@socket)}"
        @socket.write(format_message(message))
      rescue
        info "*** Connection: Sender disconnected"
        @socket.close unless socket.closed?
      end

      ##
      # Receive Celluloid Notifications for any topic subscription. This includes
      # a topic for the current user and topics for any group subscriptions.
      # Once received, messages are sent to the connected client
      def receive_message(topic, message)
        info "*** Connection: Receive message: '#{message}' from #{format_addr(@socket)}"
        send_message(message)
      rescue
        info "*** Connection: Receiver disconnected"
        @socket.close unless socket.closed?
      end

      ########################################################################
      # Command::ActorFacade Implementation
      def command_message(message)
        send_message(message)
      end

      def command_subscribe(topic, subscriber)
        subscribe(topic, subscriber)
      end

      def command_unsubscribe(subscription)
        unsubscribe(subscription)
      end

      def command_publish(topic, message)
        publish(topic, message)
      end

      def command_terminate
        async.terminate
      end
    end

  end
end
