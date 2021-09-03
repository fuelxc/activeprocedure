require "active_support/concern"

module ActiveProcedure
  module ModelConcerns
    extend ActiveSupport::Concern

    included do
      attr_accessor :model
    end

    class_methods do
      def model_class_name(name)
        @model_klass_name = name
      end

      def model_klass_name
        @model_klass_name
      end
    end

    def build_model
      @model = model_klass.new(*options)
    end

    def validate_model!
      errored!("#{model_klass_name} is not valid") unless model.valid?
    end

    def save_model
      model.save!
    rescue => e
      #do rollback
      errored!("Save #{model_klass_name}: #{e.message}")
    end

    private

    def model_klass
      Object.const_get(self.model_klass_name)
    end

    def model_klass_name
      self.class.model_klass_name
    end
  end
end