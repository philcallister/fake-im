# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'

module FakeIM
  Dir[File.dirname(__FILE__) + "/fake_im/*.rb"].each { |file| require file }
  Dir[File.dirname(__FILE__) + "/fake_im/command/**/*.rb"].each { |file| require file }
  Dir[File.dirname(__FILE__) + "/fake_im/server/**/*.rb"].each { |file| require file }
  Dir[File.dirname(__FILE__) + "/fake_im/storage/**/*.rb"].each { |file| require file }
end
