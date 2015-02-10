require 'minitest/autorun'
require_relative '../spec_helper'

describe 'Groups' do

  before do
    @groups = FakeIM::Command::Groups.new
  end

  describe '#add' do
    it 'has method defined' do
      FakeIM::Command::Groups.method_defined?(:add).must_equal true
    end

    it 'adds a group' do
      @groups.add('group1', 'subscriber1').must_equal 'subscriber1'
      @groups.groups.length.must_equal 1
    end

    it 'should not add the same group' do
      @groups.add('group1', 'subscriber1')
      @groups.add('group1', 'subscriber1').must_be_nil
    end
  end

  describe '#list' do
    it 'has method defined' do
      FakeIM::Command::Groups.method_defined?(:list).must_equal true
    end

    it 'has no groups in list' do
      @groups.list.must_be_empty
    end

    it 'has groups in list' do
      @groups.add('group1', 'subscriber1')
      @groups.add('group2', 'subscriber2')
      @groups.list.length.must_equal 2
      list = @groups.list
      list.must_include 'group1'
      list.must_include 'group2'
    end
  end

  describe '#subscriber' do
    it 'has method defined' do
      FakeIM::Command::Groups.method_defined?(:subscriber).must_equal true
    end

    it 'should not have a subscriber' do
      @groups.subscriber('group1').must_be_nil
    end

    it 'should have a subscriber' do
      @groups.add('group1', 'subscriber1')
      @groups.subscriber('group1').must_equal 'subscriber1'
    end
  end

  describe '#delete' do
    it 'has method defined' do
      FakeIM::Command::Groups.method_defined?(:delete).must_equal true
    end

    it 'should not delete a group' do
      @groups.add('group1', 'subscriber1')
      @groups.delete('group2').must_be_nil
      @groups.groups.length.must_equal 1
    end

    it 'should delete a group' do
      @groups.add('group1', 'subscriber1')
      @groups.delete('group1').must_equal 'subscriber1'
      @groups.groups.length.must_equal 0
    end
  end

end