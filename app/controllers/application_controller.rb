class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?
  before_filter :set_locale
  before_action :set_user_timezone

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :time_zone,
      :password,
      :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :first_name,
      :last_name,
      :time_zone
      )
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    instructors_path
  end
  
  def set_user_timezone
    Time.zone = current_user.time_zone if current_user.present?
  end

  # Auto-sign out locked users
  def reject_locked!
    if current_user && current_user.locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!

  # Only permits admin users
  def require_admin!
    authenticate_user!

    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end
	
  helper_method :require_admin!

  private

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
  end

# set_locale: 
		# could also pass local from a current user attribute that the user sets 
  	# ie => current_user.locale
  	# from a subdomain
  	# ie => request.subdomain
  	# or => request.env["HTTP_ACCEPT_LANGUAGE"] => From user's browser
  	# or => request.remote_ip => passed in through some kind of geolocater
  def set_locale
  	I18n.locale = params[:locale] if params[:locale].present?  
  end

  def default_url_options(options = {})
  	{locale: I18n.locale}
  end
end
