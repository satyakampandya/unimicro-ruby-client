# frozen_string_literal: true

module Unimicro
  module Resources
    # Defines methods related to wage types.
    module WageTypes
      def wage_types(params = {})
        get('api/biz/wagetypes', params)
      end
    end
  end
end
