class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Method to restrict access to admin-only pages
  def admin_only
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end

  # Redirection after sign in
  def after_sign_in_path_for(resource)
    # If the user is an admin, redirect to the admin dashboard
    if resource.admin?
      admin_dashboard_path
    else
      # Redirect to the default path for normal users
      root_path
    end
  end

  protected

  # Permitting extra parameters (like name) during Devise registration or update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
