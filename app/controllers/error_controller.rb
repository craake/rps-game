class ErrorController < ApplicationController
  # Handles 404s
  def not_found; end

  # Handles 500s
  def internal_server_error; end
end
