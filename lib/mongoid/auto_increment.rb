require 'active_support/concern'

module Mongoid
  module AutoIncrement
    extend ActiveSupport::Concern

    included do
      class_attribute :auto_increment_value_field
      class_attribute :auto_increment_class
      class_attribute :auto_incremented_fields
      class_attribute :auto_increment_classes
      class_attribute :auto_increment_collection
      class_attribute :auto_increment_class_prefix

      self.auto_increment_value_field   = 'value'
      self.auto_increment_class         = self
      self.auto_incremented_fields      = []
      self.auto_increment_classes       = []
      self.auto_increment_collection    = '__auto_increments'
      self.auto_increment_class_prefix  = self.collection_name

      set_callback :create, :before, :auto_increment!, unless: :persisted?

      self.ancestors.each do |klass|
        if klass.respond_to?(:auto_incremented_fields)
          self.auto_increment_classes << klass
        end
      end
    end

    module ClassMethods
      def auto_incremented(name, opts = {})
        if self.auto_increment_class != self
          self.auto_increment_classes = self.auto_increment_classes + [self]
          self.auto_incremented_fields = self.auto_incremented_fields.dup
          if self.auto_increment_class.auto_increment_class_prefix == self.auto_increment_class_prefix
            self.auto_increment_class_prefix = self.collection_name
          end
          self.auto_increment_class = self
        end
        self.auto_incremented_fields << name
        field name, opts.merge({type: Integer})
      end
    end

    def auto_increment!
      session = self.class.mongo_session
      self.class.auto_increment_classes.each do |klass|
        klass.auto_incremented_fields.each do |name|
          if !self[name]
            result = session.command({
              findAndModify: self.class.auto_increment_collection,
              query: {_id: "#{klass.auto_increment_class_prefix}_#{name}"},
              update: { '$inc' => { klass.auto_increment_value_field => 1 } },
              upsert: true,
              new: true,
            })
            self[name] = result.first['value'][klass.auto_increment_value_field]
          end
        end
      end
    end

    def dup
      copy = super
      self.class.auto_increment_classes.each do |klass|
        klass.auto_incremented_fields.each do |name|
          copy[name] = nil
        end
      end
      copy
    end
  end
end

