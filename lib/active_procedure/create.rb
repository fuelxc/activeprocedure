# frozen_string_literal: true
require 'active_support/callbacks'

module ActiveProcedure
  class Create < Base
    include ActiveSupport::Callbacks

    def process
      begin
        run_callbacks :build do
          build_model
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

    def build_model
      @model = model_klass.new(*options)
    end

    def validate_model!
      errored!("#{model_klass_name} is not valid") unless model.valid?
    end

    def save_model
      model.save!
    rescue => e
      errored!("Save #{model_klass_name}: #{e.message}")
    end
  end
end