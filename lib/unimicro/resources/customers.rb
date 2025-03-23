# frozen_string_literal: true

module Unimicro
  module Resources
    # Defines methods related to customers.
    module Customers
      def customers(params = {})
        get('api/biz/customers', params)
      end
    end
  end
end
