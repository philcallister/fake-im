# encoding: UTF-8

require_relative 'base_command'

module FakeIM
  module Command

    ##
    # user:<user>:<message> | Send message to user
    class UserCommand < BaseCommand

      register UserCommand.name

      def initialize(command)
        raise ArgumentError unless command.length == 3
        @user = command[1]
        @message = command.last
      end

      def self.help
        <<-HELP.pretty_heredoc
          user:<user>:<message>     | Send message to user
        HELP
      end

      def execute(actor, subscriber, auth, groups)
        raise FakeIM::Exceptions::AuthenticationError unless auth.logged_in?
        raise TypeError unless actor.is_a?(Command::ActorFacade)

        publishing_message = "from '#{auth.current_user}': #{@message}"
        status = actor.command_publish(topic, publishing_message)
        if status.empty?
          actor.command_message("WARN: '#{@user}' is not available")
        else
          actor.command_message("to '#{@user}': #{@message}")
        end
      end


      private

      def topic
        "user_#{@user}"
      end
    end

  end
end
