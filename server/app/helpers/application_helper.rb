# frozen_string_literal: true

module ApplicationHelper
  # Ensures authentication is performed, unless user is already logged in.
  def authenticate
    return if logged_in?

    redirect_to login_path and return unless request.env['omniauth.auth']

    render(file: Rails.root.join('public/403.html'), status: :forbidden, layout: false)
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    session[:authorized] == true
  end
end
