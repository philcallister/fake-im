# encoding: UTF-8

module FakeIM
  module Exceptions
    class AuthenticationError < StandardError; end
    class InvalidCommandError < StandardError; end
  end
end
