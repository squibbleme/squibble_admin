# Backend-Issue #505: Skip RebuildPathWorker Option
#
# [...]
# include Squibble::RebuildPath
# rebuild_path attribute: :attribute, only_principal: true
# [...]
#
module Squibble::RebuildPath
  extend ActiveSupport::Concern

  included do
    attr_accessor :skip_rebuild_path
    class_attribute :squibble_rebuild_path_attribute
    class_attribute :squibble_rebuild_path_use_principal

    set_squibble_rebuild_path_class_defaults

    after_save do |record|
      if !record.skip_rebuild_path && (record.send("#{squibble_rebuild_path_attribute}_changed?") || record.new_record?)
        if record.squibble_rebuild_path_use_principal && record.respond_to?(:principal_id)
          Squibble::RebuildPathWorker.perform_async(resource_class, record.principal_id)
        else
          Squibble::RebuildPathWorker.perform_async(resource_class)
        end
      end
    end

    def skip_rebuild_path
      @skip_rebuild_path ||= false
    end

    def skip_rebuild_path!
      @skip_rebuild_path = true
    end
  end

  module ClassMethods
    # Steuert bei der initialisierung, welches Attribut auf _changed?
    # überprüft wird und ob nur die Datensätze des verbundenen Principals
    # überarbeitet werden sollen
    #
    def rebuild_path(opts = {})
      self.squibble_rebuild_path_use_principal = opts[:only_principal].nil? ? false : opts[:only_principal]
      if opts[:attribute].nil?
        raise ArgumentError, 'Squibble::RebuildPath ohne spezifiziertes Attribut'
      else
        self.squibble_rebuild_path_attribute = opts[:attribute]
      end
    end

    def set_squibble_rebuild_path_class_defaults
      self.squibble_rebuild_path_attribute = nil
    end
  end

end
