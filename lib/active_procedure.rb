# frozen_string_literal: true

require_relative "active_procedure/version"
require_relative "active_procedure/model_concerns"
require_relative "active_procedure/base"
require_relative "active_procedure/create"
require_relative "active_procedure/delete"
require_relative "active_procedure/update"

module ActiveProcedure
  class Error < StandardError; end
  # Your code goes here...
end
