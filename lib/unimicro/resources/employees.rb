# frozen_string_literal: true

module Unimicro
  module Resources
    # Defines methods related to employees.
    module Employees
      def employees(params = {})
        get('api/biz/projects', params)
      end
    end
  end
end
