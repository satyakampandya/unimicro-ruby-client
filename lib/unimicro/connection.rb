# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'openssl'
require 'json'
require 'jwt'
require 'securerandom'
require 'base64'

module Unimicro
  # Defines methods to retrieve token
  class Connection
    def initialize(options)
      @client_id = options[:client_id]
      @certificate_path = options[:certificate_path]
      @certificate_password = options[:certificate_password]
      @identity_endpoint = options[:identity_endpoint]
      @token_url = build_token_url
    end

    def token
      return @token if @token && !token_expired?

      jwt = generate_client_assertion
      data = request_token(jwt)

      raise "Authentication failed: #{data}" unless data['access_token']

      store_token(data)
      @token
    end

    private

    def token_expired?
      Time.now >= @token_expires_at
    end

    def generate_client_assertion
      cert = load_certificate
      payload = build_jwt_payload
      JWT.encode(payload, cert[:key], 'RS256', { x5c: [Base64.strict_encode64(cert[:cert].to_der)] })
    end

    def load_certificate
      p12 = OpenSSL::PKCS12.new(File.binread(@certificate_path), @certificate_password)
      { key: p12.key, cert: p12.certificate }
    end

    def build_jwt_payload
      now = Time.now.to_i
      {
        iss: @client_id,
        sub: @client_id,
        aud: @token_url,
        jti: SecureRandom.uuid,
        iat: now,
        exp: now + 300
      }
    end

    def request_token(jwt)
      uri = URI.parse(@token_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path)
      request['Content-Type'] = 'application/x-www-form-urlencoded'
      request.body = encode_form_data(jwt)

      res = http.request(request)
      JSON.parse(res.body)
    end

    def build_token_url
      uri = URI.parse(@identity_endpoint)

      # Ensure the scheme is available
      raise ConfigurationError, 'Invalid identity endpoint: Missing scheme (http/https)' unless uri.scheme

      URI::Generic.build(scheme: uri.scheme, host: uri.host, path: '/connect/token').to_s
    end

    def encode_form_data(jwt)
      URI.encode_www_form(
        grant_type: 'client_credentials',
        scope: 'AppFramework',
        client_id: @client_id,
        client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
        client_assertion: jwt
      )
    end

    def store_token(data)
      @token_expires_at = Time.now + data['expires_in'].to_i
      @token = data['access_token']
    end
  end
end
