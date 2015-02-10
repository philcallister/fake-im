# encoding: UTF-8

module FakeIM
  module Command

    ##
    # All commands should extend this base command. This base command
    # includes a command builder factory, which builds the appropriate
    # command given the payload from the client.
    class BaseCommand

      @@commands = [] # Registered commands

      ## 
      # Build the appropriate command object given the payload
      def self.build_command(payload)
        unless payload.nil?
          command = payload.split(':')
          klass = qualified_const_get("FakeIM::Command::#{command.first.capitalize}Command")
          command_object = klass.new(command)
          return command_object
        end
      rescue NameError
        raise FakeIM::Exceptions::InvalidCommandError
      end

      ##
      # Return registered commands
      def self.commands
        @@commands
      end

      ##
      # Register a command class
      def self.register(klass)
        @@commands << qualified_const_get(klass)
      end

      ######################################################################
      # Abstract methods

      ##
      # Return help information for the command
      def self.help
        raise NotImplementedError
      end

      ##
      # Execute the given command object
      def execute(actor, subscriber, auth, groups, &publishing)
      	raise NotImplementedError
      end
    end

  end
end
