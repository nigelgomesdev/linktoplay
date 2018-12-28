module Scopable
  extend ActiveSupport::Concern

  module ClassMethods
    def scoped(scopable_params)
      results = self.where(nil)
      scopable_params.each_pair do |scope_name, scope_arg|
        results = results.public_send(scope_name, scope_arg) 
      end
      results
    end
  end
end