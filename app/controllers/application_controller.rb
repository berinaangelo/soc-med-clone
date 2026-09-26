class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Devise's own strong-params setup doesn't know about app-owned fields (data-model-schema.md) —
  # :name is collected at sign-up per profile-editing.md/signup.html; bio/profile_picture are
  # edited later via the (not-yet-built) profile-editing screen, not at sign-up.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
