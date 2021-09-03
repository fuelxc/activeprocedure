# frozen_string_literal: true

module ActiveProcedure
  class Base
    include ActiveProcedure::ModelConcerns
    
    attr_reader :options, :errors

    def initialize(*options)
      @options = options
      @errors = []
    end

    def self.process(*options)
      operation = new(*options)
      operation.process
    end

    def success?
      errors.empty?
    end

    def errored?
      !success?
    end

    def errored!(err)
      errored(err)
      raise ActiveProcedure::Error
    end

    def errored(err)
      @errors << err
    end
  end
end