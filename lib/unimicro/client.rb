# frozen_string_literal: true

Dir[File.expand_path('resources/*.rb', __dir__)].sort.each { |f| require f }

module Unimicro
  class ConfigurationError < StandardError; end

  # Wrapper for the Unimicro API.
  class Client
    include Unimicro::Request
    include Unimicro::Resources::Customers

    attr_reader :connection, :endpoint, :options, :company_key

    def initialize(options = {})
      @options = options
      validate_configuration
      @company_key = options[:company_key] || ENV.fetch('UNIMICO_COMPANY_KEY', nil)
      @endpoint = options[:endpoint] || ENV.fetch('UNIMICRO_API_ENDPOINT', nil)
      @connection = Unimicro::Connection.new(options)
    end

    private

    def validate_configuration
      missing_configs = required_configurations.select { |key| options[key].nil? }

      return if missing_configs.empty?

      raise ConfigurationError, "Missing required configurations: #{missing_configs.join(', ')}"
    end

    def required_configurations
      %i[endpoint company_key client_id certificate_path certificate_password]
    end
  end
end
