# frozen_string_literal: true

module Unimicro
  # Defines constants and methods related to configuration.
  module Configuration
    VALID_CONFIGURATIONS = %i[
      api_endpoint
      identity_endpoint
      company_key
      client_id
      certificate_path
      certificate_password
    ].freeze

    REQUIRED_CONFIGURATIONS = %i[
      api_endpoint
      identity_endpoint
      company_key
      client_id
      certificate_path
      certificate_password
    ].freeze

    attr_accessor(*VALID_CONFIGURATIONS)

    def configure
      yield self
    end

    def options
      VALID_CONFIGURATIONS.each_with_object({}) do |key, hash|
        hash[key] = send(key)
      end
    end
  end
end
