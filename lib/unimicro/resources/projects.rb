# frozen_string_literal: true

module Unimicro
  module Resources
    # Defines methods related to projects.
    module Projects
      def projects(params = {})
        get('api/biz/projects', params)
      end
    end
  end
end
