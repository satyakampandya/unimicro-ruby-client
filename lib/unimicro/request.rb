# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

module Unimicro
  # Defines methods to perform API calls
  module Request
    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    def put(path, options = {})
      request(:put, path, options)
    end

    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    def request(method, path, options = {})
      uri = build_uri(path, options[:query])
      req = build_http_request(method, uri, options)

      response = execute_http_request(uri, req)
      parse_response(response)
    end

    def build_uri(path, query_params)
      uri = URI.join(@endpoint, path)
      uri.query = URI.encode_www_form(query_params) if query_params
      uri
    end

    def execute_http_request(uri, req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.request(req)
    end

    def build_http_request(method, uri, options)
      klass = fetch_http_method_class(method)

      req = klass.new(uri)
      add_headers(req)
      add_body(req, options[:body])

      req
    end

    def fetch_http_method_class(method)
      {
        get: Net::HTTP::Get,
        post: Net::HTTP::Post,
        put: Net::HTTP::Put,
        delete: Net::HTTP::Delete
      }[method] || raise(ArgumentError, "Unsupported HTTP method: #{method}")
    end

    def add_headers(req)
      req['Authorization'] = "Bearer #{connection.token}"
      req['Content-Type'] = 'application/json'
      req['CompanyKey'] = @company_key
    end

    def add_body(req, body)
      req.body = body.to_json if body
    end

    def parse_response(res)
      body = res.body.to_s.strip
      json = body.empty? ? {} : JSON.parse(body)

      raise "API request failed (#{res.code}): #{json}" unless res.is_a?(Net::HTTPSuccess)

      json
    end
  end
end
