# encoding: UTF-8

module FakeIM
  module Storage
    module Plugin

      class BasePlugin

        ######################################################################
        # Abstract methods

        ##
        # Add a message for the given user
        def add_user_message(user, message)
          raise NotImplementedError
        end

        ##
        # Add a message for the given group
        def add_group_message(group, message)
          raise NotImplementedError
        end
      end

    end
  end
end
