# encoding: UTF-8

module FakeIM
  module Storage

    class Factory

      private_class_method :new

      ##
      # Return a storage plugin implementation given the plugin name
      def self.create_storage(plugin)
        klass = qualified_const_get("FakeIM::Storage::Plugin::#{plugin.to_s.capitalize}Plugin")
        storage_plugin = klass.new
        return storage_plugin
      rescue NameError => e
        raise FakeIM::Exceptions::InvalidStoragePluginError.new(e)
      end
    end
  
  end
end
