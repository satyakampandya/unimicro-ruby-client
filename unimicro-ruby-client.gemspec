# frozen_string_literal: true

require_relative 'lib/unimicro/version'

Gem::Specification.new do |spec|
  spec.name = 'unimicro-ruby-client' # Name of the gem
  spec.version = Unimicro::VERSION # Version of the gem
  spec.authors = ['Satyakam Pandya']
  spec.email = ['satyakampandya@gmail.com']

  spec.summary = 'Ruby client for interacting with the Unimicro API' # Short summary for RubyGems
  spec.description = 'A Ruby gem for easily interacting with the Unimicro API. It provides a simple ' \
                     'interface for authentication and API calls, allowing seamless integration with the ' \
                     'Unimicro platform.'
  spec.homepage = 'https://github.com/satyakampandya/unimicro-ruby-client' # Link to the gem's homepage
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0' # Minimum Ruby version support

  # Set the allowed push host for your gem server (typically RubyGems or a private server)
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/satyakampandya/unimicro-ruby-client'
  spec.metadata['changelog_uri'] = 'https://github.com/satyakampandya/unimicro-ruby-client/blob/main/CHANGELOG.md'

  # Specify which files should be included in the gem
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe' # Directory for executables
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) } # Executables to include
  spec.require_paths = ['lib'] # Folders to require when loading the gem

  spec.add_dependency 'jwt', '~> 2.10'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
