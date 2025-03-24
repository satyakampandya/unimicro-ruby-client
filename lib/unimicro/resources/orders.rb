# frozen_string_literal: true

module Unimicro
  module Resources
    # Defines methods related to orders.
    module Orders
      def orders(params = {})
        get('api/biz/orders', params)
      end

      def order(id, params = {})
        get("api/biz/orders/#{url_encode id}", params)
      end
    end
  end
end
