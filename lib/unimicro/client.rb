# frozen_string_literal: true

Dir[File.expand_path('resources/*.rb', __dir__)].sort.each { |f| require f }

module Unimicro
  class ConfigurationError < StandardError; end

  # Wrapper for the Unimicro API.
  class Client
    include Unimicro::Request
    include Unimicro::Resources::Customers

    attr_reader :options, :api_endpoint, :identity_endpoint, :company_key,
                :client_id, :certificate_path, :certificate_password, :connection

    def initialize(options = {})
      @options = options
      load_configurations
      validate_configurations
      @connection = Unimicro::Connection.new(connection_options)
    end

    private

    def load_configurations
      Configuration::VALID_CONFIGURATIONS.each do |key|
        instance_variable_set(
          "@#{key}",
          options[key] || ENV.fetch("UNIMICRO_#{key.to_s.upcase}", nil)
        )
      end
    end

    def validate_configurations
      missing_configs = Configuration::REQUIRED_CONFIGURATIONS.select { |key| instance_variable_get("@#{key}").nil? }

      return if missing_configs.empty?

      raise ConfigurationError, "Missing required configurations: #{missing_configs.join(', ')}"
    end

    def connection_options
      {
        client_id: @client_id,
        certificate_path: @certificate_path,
        certificate_password: @certificate_password,
        identity_endpoint: @identity_endpoint
      }
    end
  end
end
