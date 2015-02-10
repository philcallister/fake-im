# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'

Dir[File.dirname(__FILE__) + "/../lib/fake_im/*.rb"].each { |file| require file }
Dir[File.dirname(__FILE__) + "/../lib/fake_im/command/**/*.rb"].each { |file| require file }
Dir[File.dirname(__FILE__) + "/../lib/fake_im/server/**/*.rb"].each { |file| require file }
Dir[File.dirname(__FILE__) + "/../lib/fake_im/storage/**/*.rb"].each { |file| require file }

# Dir[File.dirname(__FILE__) + "/../lib/fake_im/**/*.rb"].each { |file| require file }
