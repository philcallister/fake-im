# encoding: UTF-8

require_relative 'base_plugin'

module FakeIM
  module Storage
    module Plugin

      class NullPlugin < BasePlugin

        ##
        # Add a message for the given user
        def add_user_message(user, message)
          # do nothing...messages fall into null bit bucket
        end

        ##
        # Add a message for the given group
        def add_group_message(group, message)
          # do nothing...messages fall into null bit bucket
        end
      end

    end
  end
end
