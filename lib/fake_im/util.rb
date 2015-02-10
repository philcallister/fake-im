# encoding: UTF-8

module FakeIM
  module Util

    def format_addr(socket)
      _, port, host = socket.peeraddr
      "#{host}:#{port}"
    end

    def format_message(message)
      "### #{Time.new}: #{message}\n"
    end

  end
end
