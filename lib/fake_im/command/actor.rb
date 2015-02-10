# encoding: UTF-8

module FakeIM
  module Command

    ##
    # All Actors accessing the command processor must
    # implement this interface.
    class Actor

      ##
      # A message needs to be sent to the client
      def command_message(message)
        raise NotImplementedError
      end
    end

  end
end
