# frozen_string_literal: true
require 'active_support/callbacks'

module ActiveProcedure
  class Delete < Base
    include ActiveSupport::Callbacks

    def initialize(model, changeset)
      @model = model
      @changeset = changeset.to_hash
      super
    end

    def process
      begin
        run_callbacks :assign_attributes do
          assign_attributes
        end
       
        run_callbacks :validation do
          validate_model!
        end
        
        run_callbacks :save do
          save_model
        end
      rescue => e
        error
      end
      self
    end

    private

    def assign_attributes
      @product = item_klass.new(*options)
    end

    def validate_model!
      errored!("#{model_klass_name} is not valid") unless model.valid?
    end

    def save_model
      item.save!
    rescue => e
      # rollback
      errored!("save_product: #{e.message}")
    end
  end
end