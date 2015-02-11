# encoding: UTF-8

require 'optparse'

module FakeIM
  class CLI

    def self.parse(args, client=false)
      options = { host: 'localhost', port: 10408, storage: 'file' }
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($0)} [options]"

        # Client only
        if client
          options[:user] = 'phil@example.com'
          opts.on('-uUSER', '--user=USER', 'IM User') do |u|
            options[:user] = u
          end
        end

        opts.on("-hHOST", "--hostname=HOST", "Server hostname") do |hn|
          options[:host] = hn
        end
        opts.on("-pPORT", "--port=PORT", "Server port") do |p|
          options[:port] = p
        end
        opts.on("-sSTORAGE", "--storage=STORAGE", "Storage plugin") do |s|
          options[:storage] = s.to_sym
        end
        opts.on('--help', 'Show usage') do |h|
          options[:help] = h
        end
      end

      begin
        parser.parse!(args)
      rescue
        puts parser
        exit(1)
      end

      if options[:help]
        puts parser
        exit
      end

      options
    end

    ## Server Command
    class Server

      def self.start
        options = CLI.parse(ARGV)
        begin
          # Don't daemonize the server. Just running from the
          # console for this example.
          FakeIM::Storage::Manager.new(options[:storage])
          FakeIM::Server::ConnectionServer.run(options)
        rescue Exception => e
          puts "*** CLI: #{e.message}"
          exit(1)
        end
      end

    end

    ## Client Command
    class Client

      def self.start
        puts "Not implemented yet. Please use 'telnet'"
      end

    end

  end
end
