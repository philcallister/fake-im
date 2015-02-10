# encoding: UTF-8

require 'celluloid'

module FakeIM
  module Storage

    class Manager
      include Celluloid
      include Celluloid::Logger

      finalizer :shutdown

      def initialize
        info "*** Storage Manager: Starting..."
        Celluloid::Actor[:storage] = Actor.current
      end

      def shutdown
        info "*** Storage Manager: Shutdown..."
      rescue
        # do nothing
      end

      ##
      # Store the given message in the given bucket (topic)
      def store_message(topic, message)
        info "!!!!! store_message: #{topic} | #{message}"
      end
    end

  end
end
