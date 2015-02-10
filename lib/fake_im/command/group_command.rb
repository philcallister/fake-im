# encoding: UTF-8

require_relative 'base_command'

module FakeIM
  module Command

    ##
    # group:show:list           | Show subscribed groups
    # group:subscribe:<group>   | Subscribe to the group
    # group:unsubscribe:<group> | Unsubscribe from the group
    # group:<group>:<message>   | Send a message to the group
    class GroupCommand < BaseCommand

      register GroupCommand.name

      def initialize(command)
        raise ArgumentError unless command.length == 3
        @entry1 = command[1]
        @entry2 = command.last
      end

      def self.help
        <<-HELP.pretty_heredoc
          group:show:list           | Show subscribed groups
          group:subscribe:<group>   | Subscribe to the group
          group:unsubscribe:<group> | Unsubscribe from the group
          group:<group>:<message>   | Send a message to the group
        HELP
      end

      def execute(actor, subscriber, auth, groups, &publishing)
        raise FakeIM::Exceptions::AuthenticationError unless auth.logged_in?
        raise TypeError unless actor.is_a?(Command::Actor)

        case @entry1.to_sym

        when :show
          if @entry2.to_sym == :list
            groups = groups.list.join(', ')
            actor.command_message("Groups: [#{groups}]")
          else
            raise FakeIM::Exceptions::InvalidCommandError
          end

        when :subscribe
          group = @entry2
          unless groups.has_a?(group)
            subscription = actor.subscribe(topic(group), subscriber)
            groups.add(group, subscription)
            actor.command_message("Group Subscribe: '#{group}'")
          else
            actor.command_message("WARN: Already belong to group: '#{group}'")
          end

        when :unsubscribe
          group = @entry2
          if groups.has_a?(group)
            subscription = groups.subscriber(group)
            actor.unsubscribe(subscription)
            groups.delete(group)
            actor.command_message("Group Unsubscribe: '#{group}'")
          else
            actor.command_message("WARN: Do not belong to group: '#{group}'")
          end

        else # Group message
          group = @entry1
          if groups.has_a?(group)
            message = @entry2
            publish_message = "from '#{auth.current_user}' | to '#{group}': #{message}"
            actor.publish(topic(group), publish_message)
            publishing.call(topic(group), publish_message)
          else
            actor.command_message("WARN: Do not belong to group: '#{group}'")
          end
        end
      end


      private

      def topic(group)
        "group_#{group}" 
      end

    end

  end
end
