# encoding: UTF-8

require 'celluloid'

module FakeIM
  module Storage

    class Manager
      include Celluloid
      include Celluloid::Logger

      finalizer :shutdown

      def initialize(storage_plugin)
        info "+++ Storage Manager: Starting with: #{storage_plugin}"
        Celluloid::Actor[:storage] = Actor.current
        @storage = FakeIM::Storage::Factory.create_storage(storage_plugin)
      end

      def shutdown
        info "+++ Storage Manager: Shutdown..."
      rescue
        # do nothing
      end

      ##
      # Store the given message in the proper user/group bucket
      def store_message(topic, message)
        info "+++ Storage Manager: Message: #{topic} | #{message}"
        bucket = topic.split('_')
        bucket.first == 'user' ? @storage.add_user_message(bucket.last, message) :
                                 @storage.add_group_message(bucket.last, message)
      end
    end

  end
end
