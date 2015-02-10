# encoding: UTF-8

module FakeIM
  module Command

    ##
    # Maintain login state. This is obviously a completely
    # bogus authentication scheme. Just using this as an
    # example to show how authentication check could be
    # injected into the command pattern
    class Auth

      def initialize
        @login = false
        @user = nil
      end

      def login(user)
        @login = true
        @user = user
      end

      def logout
        @login = false
        @user = nil
      end

      def logged_in?
        @login
      end

      def current_user
        @user
      end
    end

  end
end
