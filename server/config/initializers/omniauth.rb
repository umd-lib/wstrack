# OmniAuth CAS Strategy initializer

Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['HOST'].blank?
    # Only warn, so that HOST is need not be set for testing
    Rails.logger.warn('"HOST" environment variable not defined.')
  end

  OmniAuth.config.path_prefix = '/users/auth'
  saml_path_prefix = OmniAuth.config.path_prefix

  if ENV['HOST'].present?
    saml_host = ENV['HOST']
    saml_scheme = 'https'
    if saml_host.include? "local"
      # Configure SAML host and scheme for local development environment
      saml_host = "#{saml_host}:#{ENV.fetch("PORT") { 3000 }}"
      saml_scheme = 'http'
    end
    Rails.logger.info("Configuring SAML authentication: saml_scheme=#{saml_scheme}, saml_host=#{saml_host}")

    # Saml Configuration
    provider :saml,
      sp_entity_id: saml_host,
      assertion_consumer_service_url: "#{saml_scheme}://#{saml_host}#{saml_path_prefix}/saml/callback",
      idp_cert_fingerprint: 'B8:98:58:08:FA:42:BB:D2:86:14:49:61:8F:B9:BF:7B:45:1A:7C:67',
      idp_sso_service_url: 'https://shib.idm.umd.edu/shibboleth-idp/profile/SAML2/Redirect/SSO',
      idp_slo_service_url: 'https://shib.idm.umd.edu/shibboleth-idp/profile/Logout',
      uid_attribute: 'urn:oid:0.9.2342.19200300.100.1.1',
      attribute_statements: { email: ['urn:oid:0.9.2342.19200300.100.1.3'], roles: ['urn:oid:1.3.6.1.4.1.5923.1.1.1.7'] },

      # Following settings used by ruby-saml gem (https://github.com/onelogin/ruby-saml)
      security: {
        authn_requests_signed: true,
        want_assertions_signed: true,
        digest_method: 'http://www.w3.org/2000/09/xmldsig#sha1',
        signature_method: 'http://www.w3.org/2000/09/xmldsig#rsa-sha1',
        embed_sign: false,
        metadata_signed: false,
      },
      private_key: ENV['SAML_SP_PRIVATE_KEY'],
      certificate: ENV['SAML_SP_CERTIFICATE']
  end
end

OmniAuth.config.logger = Rails.logger
