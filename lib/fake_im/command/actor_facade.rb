# encoding: UTF-8

module FakeIM
  module Command

    ##
    # All Actors accessing the command processor must implement this
    # interface. This Actor interface provides a facade layer for real
    # actors. By creating a simple facade, we can reduce the complexity
    # of the larger Actor object lurking behind this. It also makes
    # testing easier, as this object is easier to mock. Of course, for
    # a small example project like this, a facade does look like a bit
    # overkill, right? 
    class ActorFacade

      ##
      # A message needs to be sent to the client
      def command_message(message)
        raise NotImplementedError
      end

      def command_subscribe(topic, subscriber)
        raise NotImplementedError
      end

      def command_unsubscribe(subscription)
        raise NotImplementedError
      end

      def command_publish(topic, message)
        raise NotImplementedError
      end

      def command_terminate
        raise NotImplementedError
      end
    end

  end
end
