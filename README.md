
# Unimicro Ruby Client

`unimicro-ruby-client` is a Ruby client for interacting with the Unimicro API. It provides a simple and intuitive interface to authenticate and interact with the Unimicro platform using Ruby.

## Installation

To install the gem, add it to your Gemfile:

```ruby
gem 'unimicro-ruby-client'
```

Then run:

```bash
bundle install
```

Or install it directly using `gem`:

```bash
gem install unimicro-ruby-client
```

## Configuration

Before using the client, you'll need to configure the endpoint and authentication details. You can configure it via a block in your Ruby code:

```ruby
Unimicro.configure do |config|
  config.endpoint = 'https://example.net/api/v1' # The API endpoint URL
  config.client_id = 'your-client-id'            # Your client ID
  config.company_key = 'your-company-key'        # Your client ID
  config.certificate_path = '/path/to/your/certificate.p12'  # Path to the client certificate
  config.certificate_password = 'your-password'  # Password for the certificate (if any)
end
```

### Environment Variables [WIP]

Alternatively, you can set the required values using environment variables:

- `UNIMICRO_API_ENDPOINT`
- `UNIMICRO_CLIENT_ID`
- `UNIMICRO_COMPANY_KEY`
- `UNIMICRO_CERTIFICATE_PATH`
- `UNIMICRO_CERTIFICATE_PASSWORD`

## Usage

Once the gem is configured, you can interact with the Unimicro API. For example, to fetch customer details:

```ruby
# Get customers information
customers = Unimicro.customers
puts customers
```

The gem automatically handles authentication using the server application approach, including token retrieval and management.

## Authentication

This gem supports the **server application** authentication approach. You'll need to provide the following for the authentication process to work:

- **Client ID**: Provided by Unimicro.
- **Certificate**: A certificate provided by Unimicro to securely authenticate API requests.

The gem will retrieve a token and use it for subsequent API calls.

### Example - Customers API

Here's an example of using the `Unimicro` client to fetch customers:

```ruby
customers = Unimicro.customers
customers.each do |customer|
  puts customer['CustomerNumber']
end
```

## Available API Resources

The `unimicro-ruby-client` gem supports various API resources. For now, we have the **Customer API** available, but more resources will be added in the future.

## Development

If you'd like to contribute to the development of this gem, please follow these steps:

1. Fork this repository.
2. Create a new branch for your changes.
3. Run tests with `rspec` to ensure everything is working.
4. Push your changes and create a pull request.

To run the tests locally:

```bash
rspec
```

## Contributing

We welcome contributions to this gem! Feel free to submit issues or pull requests with bug fixes, improvements, or new features.

### Development Dependencies

This gem includes the following development dependencies:

- **RSpec** for testing
- **RuboCop** for code linting
- **Bundler** for managing dependencies

To install the development dependencies, run:

```bash
bundle install --with development
```

## License

This gem is released under the [MIT License](LICENSE).
