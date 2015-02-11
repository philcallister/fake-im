# encoding: UTF-8

require_relative 'base_command'

module FakeIM
  module Command

    ##
    # help | Show command help
    class HelpCommand < BaseCommand

      register HelpCommand.name

      def initialize(command)
        raise ArgumentError unless command.length == 1
      end

      def self.help
        <<-HELP.pretty_heredoc
          help                      | Show command help
        HELP
      end

      def execute(actor, subscriber, auth, groups)
        raise TypeError unless actor.is_a?(Command::ActorFacade)

        command_help = BaseCommand.commands.map { |klass| klass.help }.sort.join('')
        help = "Welcome to FakeIM Server. First thing you'll want to do is 'login'\n" + command_help
        actor.command_message(help)
      end
    end

  end
end
