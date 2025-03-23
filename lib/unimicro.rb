# frozen_string_literal: true

require 'unimicro/version'
require 'unimicro/configuration'
require 'unimicro/connection'
require 'unimicro/request'
require 'unimicro/client'

# nodoc
module Unimicro
  class << self
    include Unimicro::Configuration

    def client
      @client ||= Unimicro::Client.new(options)
    end

    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)

      client.send(method, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name) || super
    end
  end
end
