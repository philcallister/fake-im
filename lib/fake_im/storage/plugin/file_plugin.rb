# encoding: UTF-8

require 'fileutils'

require_relative 'base_plugin'

module FakeIM
  module Storage
    module Plugin

      class FilePlugin < BasePlugin

        USER_DIR = './.storage/user'
        GROUP_DIR = './.storage/group'

        def initialize
          FileUtils::mkdir_p %W( #{USER_DIR} #{GROUP_DIR} )
        end

        ##
        # Add a message for the given user
        def add_user_message(user, message)
          write_message(USER_DIR, "#{user}", message)
        end

        ##
        # Add a message for the given group
        def add_group_message(group, message)
          write_message(GROUP_DIR, "#{group}", message)
        end

        private

        def write_message(dir, file, message)
          File.open("#{dir}/#{file}.txt", "a:UTF-8") do |f|
            f.puts message  
          end
        end

      end

    end
  end
end
