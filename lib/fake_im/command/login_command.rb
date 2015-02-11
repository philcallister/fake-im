# encoding: UTF-8

require_relative 'base_command'

module FakeIM
  module Command

    ##
    # login:<user> | Login with user
    class LoginCommand < BaseCommand

      register LoginCommand.name

      def initialize(command)
        raise ArgumentError unless command.length == 2
        @user = command.last
      end

      def self.help
        <<-HELP.pretty_heredoc
          login:<user>              | Login with user
        HELP
      end

      def execute(actor, subscriber, auth, groups)
        raise TypeError unless actor.is_a?(Command::ActorFacade)

        unless auth.logged_in?
          auth.login(@user)
          actor.command_subscribe("user_#{@user}", subscriber)
          actor.command_message("Login: #{@user}")
        else
          actor.command_message("WARN: Already logged in as: '#{@user}'")
        end
      end
    end

  end
end
