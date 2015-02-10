# encoding: UTF-8

require_relative 'base_command'

module FakeIM
  module Command

    ##
    # quit | Quit the IM session
    class QuitCommand < BaseCommand

      register QuitCommand.name

      def initialize(command)
        raise ArgumentError unless command.length == 1
      end

      def self.help
        <<-HELP.pretty_heredoc
          quit                      | Quit the IM session
        HELP
      end

      def execute(actor, subscriber, auth, groups, &publishing)
        actor.async.terminate
      end
    end

  end
end
