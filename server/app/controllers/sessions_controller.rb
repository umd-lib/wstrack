# frozen_string_literal: true

# Omniauth authentication controller
class SessionsController < ApplicationController
  # "new" and "create" are part of SAML authentication, so skip authenticate
  # action for those endpoints
  skip_before_action :authenticate, only: %i[new create]
  # Also skip forgery protection for "create", because response is coming from
  # the SAML IdP
  skip_forgery_protection only: :create

  def new
    render :new
  end

  def create
    # Call reset_session to prevent "session fixation" attacks
    # See Section "2.7 - Session Fixation - Countermeasures" in
    # https://guides.rubyonrails.org/v6.1/security.html
    reset_session

    auth_hash = request.env['omniauth.auth']
    roles = [*auth_hash.info.roles]
    display_access_forbidden and return unless roles_allowed?(roles)

    session[:authorized] = true
    redirect_to root_path
  end

  private

    def display_access_forbidden
      render(file: Rails.root.join('public/403.html'), status: :forbidden, layout: false)
    end

    def roles_allowed?(roles)
      valid_role = 'workstationtracking-administrator'

      # Grouper groups may be returned in different of uppercase/lowercase
      # forms, so need to do a case-insensitive comparison.
      downcased_roles = roles.map(&:downcase)
      downcased_roles.include? valid_role
    end
end
