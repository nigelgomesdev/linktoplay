# frozen_string_literal: true

# Scopable: apply scopes to create filter chain to Models
module Scopable
  extend ActiveSupport::Concern

  # Adding to ClassMethods
  module ClassMethods
    def scoped(scopable_params)
      results = where(nil)
      scopable_params.each_pair do |scope_name, scope_arg|
        results = results.public_send(scope_name, scope_arg)
      end
      results
    end
  end
end
