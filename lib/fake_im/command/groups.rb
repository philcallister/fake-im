# encoding: UTF-8

module FakeIM
  module Command

    ##
    # Group subscriptions
    class Groups

      attr_accessor :groups

      def initialize
        self.groups = {}
      end

      def list
        groups = self.groups.map { |k,v| k.to_s }
      end

      def subscriber(group)
        group = group.to_sym
        self.groups[group]
      end

      def add(group, subscriber)
        group = group.to_sym
        self.groups[group] = subscriber unless has_a?(group)
      end

      def delete(group)
        group = group.to_sym
        self.groups.delete(group)
      end

      def has_a?(group)
        group = group.to_sym
        self.groups.include?(group)
      end
    end

  end
end
